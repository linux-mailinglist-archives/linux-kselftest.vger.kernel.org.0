Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00D915A619A
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Aug 2022 13:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbiH3LWo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 Aug 2022 07:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbiH3LWm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 Aug 2022 07:22:42 -0400
Received: from smtp-190a.mail.infomaniak.ch (smtp-190a.mail.infomaniak.ch [IPv6:2001:1600:4:17::190a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5FC9F32F3
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Aug 2022 04:22:39 -0700 (PDT)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4MH4fP5JpWzMqZGW;
        Tue, 30 Aug 2022 13:22:37 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4MH4fP0wk3zlh8T5;
        Tue, 30 Aug 2022 13:22:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1661858557;
        bh=oTAsEX4jtRncYkonlQ5yqqIyY7BL0fVt/IXLQVoyFPI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Tr1U4QMmwu0OqYWwnPhbq0UjR8tckF+/TQewme/kjKnyXfhUJn3mNSJ+mW0s3g732
         xcROOERjCIkjegRVNKO96nQPQFimyD5KX0y5tP+q5llD22jdo0Mt0IPDWMY2IBuF3C
         HDml75lG2XGnYkJ4VW+KwOswrH5CVxE2EJww3Ru0=
Message-ID: <4f5adce6-50a6-ca2e-6146-71626d2af197@digikod.net>
Date:   Tue, 30 Aug 2022 13:22:36 +0200
MIME-Version: 1.0
User-Agent: 
Subject: Re: [PATCH -next v2 2/6] landlock: abstract walk_to_visible_parent()
 helper
Content-Language: en-US
To:     Xiu Jianfeng <xiujianfeng@huawei.com>, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com, shuah@kernel.org,
        corbet@lwn.net
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20220827111215.131442-1-xiujianfeng@huawei.com>
 <20220827111215.131442-3-xiujianfeng@huawei.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <20220827111215.131442-3-xiujianfeng@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 27/08/2022 13:12, Xiu Jianfeng wrote:
> This helper will be used in the next commit which supports chmod and
> chown access rights restriction.
> 
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> ---
>   security/landlock/fs.c | 67 ++++++++++++++++++++++++++++++------------
>   1 file changed, 49 insertions(+), 18 deletions(-)
> 
> diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> index c57f581a9cd5..4ef614a4ea22 100644
> --- a/security/landlock/fs.c
> +++ b/security/landlock/fs.c
> @@ -38,6 +38,44 @@
>   #include "ruleset.h"
>   #include "setup.h"
>   
> +enum walk_result {
> +	WALK_CONTINUE,
> +	WALK_TO_REAL_ROOT,
> +	WALK_TO_DISCONN_ROOT,

Why did you created these results instead of the ones I proposed?


> +};
> +
> +/*
> + * walk to the visible parent, caller should call path_get()/path_put()
> + * before/after this helpler.
> + *
> + * Returns:
> + * - WALK_TO_REAL_ROOT if walk to the real root;
> + * - WALK_TO_DISCONN_ROOT if walk to disconnected root;
> + * - WALK_CONTINUE otherwise.
> + */
> +static enum walk_result walk_to_visible_parent(struct path *path)
> +{
> +	struct dentry *parent_dentry;
> +jump_up:
> +	if (path->dentry == path->mnt->mnt_root) {
> +		if (follow_up(path)) {
> +			/* Ignores hidden mount points. */
> +			goto jump_up;
> +		} else {
> +			/* Stop at the real root. */
> +			return WALK_TO_REAL_ROOT;
> +		}
> +	}
> +	/* Stops at disconnected root directories. */
> +	if (unlikely(IS_ROOT(path->dentry)))
> +		return WALK_TO_DISCONN_ROOT;
> +	parent_dentry = dget_parent(path->dentry);
> +	dput(path->dentry);
> +	path->dentry = parent_dentry;
> +
> +	return WALK_CONTINUE;
> +}
> +
>   /* Underlying object management */
>   
>   static void release_inode(struct landlock_object *const object)
> @@ -539,8 +577,8 @@ static int check_access_path_dual(
>   	 * restriction.
>   	 */
>   	while (true) {
> -		struct dentry *parent_dentry;
>   		const struct landlock_rule *rule;
> +		enum walk_result wr;

Please make the names understandable. In this case this variable may not 
be needed anyway.


>   
>   		/*
>   		 * If at least all accesses allowed on the destination are
> @@ -588,20 +626,12 @@ static int check_access_path_dual(
>   		if (allowed_parent1 && allowed_parent2)
>   			break;
>   
> -jump_up:
> -		if (walker_path.dentry == walker_path.mnt->mnt_root) {
> -			if (follow_up(&walker_path)) {
> -				/* Ignores hidden mount points. */
> -				goto jump_up;
> -			} else {
> -				/*
> -				 * Stops at the real root.  Denies access
> -				 * because not all layers have granted access.
> -				 */
> -				break;
> -			}
> -		}
> -		if (unlikely(IS_ROOT(walker_path.dentry))) {
> +		wr = walk_to_visible_parent(&walker_path);
> +		switch (wr) {
> +		case WALK_TO_REAL_ROOT:
> +			/* Stop at the real root. */
> +			goto out;
> +		case WALK_TO_DISCONN_ROOT:
>   			/*
>   			 * Stops at disconnected root directories.  Only allows
>   			 * access to internal filesystems (e.g. nsfs, which is
> @@ -609,12 +639,13 @@ static int check_access_path_dual(
>   			 */
>   			allowed_parent1 = allowed_parent2 =
>   				!!(walker_path.mnt->mnt_flags & MNT_INTERNAL);

Why not include this check in the helper? This is then not checked in 
patch 3 with current_check_access_path_context_only(), which is a bug.


> +			goto out;
> +		case WALK_CONTINUE:
> +		default:
>   			break;
>   		}
> -		parent_dentry = dget_parent(walker_path.dentry);
> -		dput(walker_path.dentry);
> -		walker_path.dentry = parent_dentry;
>   	}
> +out:
>   	path_put(&walker_path);
>   
>   	if (allowed_parent1 && allowed_parent2)
