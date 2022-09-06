Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90A005AE81D
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Sep 2022 14:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240140AbiIFMa1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Sep 2022 08:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240153AbiIFMaI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Sep 2022 08:30:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC3217F0B5;
        Tue,  6 Sep 2022 05:26:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5FE3FB818B0;
        Tue,  6 Sep 2022 12:26:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D2F5C433D6;
        Tue,  6 Sep 2022 12:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662467203;
        bh=vBnVQddkD3wuQTAf7okaHBtzjrZaWMsmKiXkLojBoX4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kT90mA3zxzorCquf+AFxWdAotUQRjmeFFLs4gTjOORu/1SQ8P/t8RNuA1gsQ4MONY
         o7kLn7Q/Z9CXmgkaUgbjklCvxmOa9GFyXO0zojlPZtTQ2koBveFQkhPjwBmyfR8EEM
         jeYFt33ituMVBSCqpVn0Zloa8uiFt6POOPbEYFp6efKWlWHHKy2FxwlIVb7CSbDF9K
         gKUuHY7IHuhkE4j3IjVc9oP2r7GT276CQzUn3oLr4+VLSbhFoLGb5xHgy/EjqlLS17
         nUIhq4WgUq7P4Upm3ydw6AcbiTQuXKIiG9UTl5TQLwtoCvdf02YA2NIyrkYxOHhYJX
         44BsAf6kLg7RA==
Date:   Tue, 6 Sep 2022 15:26:39 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, deso@posteo.net, dhowells@redhat.com,
        haoluo@google.com, jmorris@namei.org, john.fastabend@gmail.com,
        jolsa@kernel.org, keyrings@vger.kernel.org, kpsingh@kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org, martin.lau@linux.dev,
        memxor@gmail.com, mingo@redhat.com, mykolal@fb.com,
        paul@paul-moore.com, roberto.sassu@huawei.com, rostedt@goodmis.org,
        sdf@google.com, serge@hallyn.com, shuah@kernel.org,
        song@kernel.org, yhs@fb.com
Subject: Re: [PATCH v17 05/12] KEYS: Move KEY_LOOKUP_ to include/linux/key.h
 and define KEY_LOOKUP_ALL
Message-ID: <Yxc8fwOgZ+UY0jiX@kernel.org>
References: <YxcyeZBHGPNQB+qJ@kernel.org>
 <20220906121506.165001-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220906121506.165001-1-roberto.sassu@huaweicloud.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Sep 06, 2022 at 02:15:06PM +0200, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
> 
> In preparation for the patch that introduces the bpf_lookup_user_key() eBPF
> kfunc, move KEY_LOOKUP_ definitions to include/linux/key.h, to be able to
> validate the kfunc parameters. Add them to enum key_lookup_flag, so that
> all the current ones and the ones defined in the future are automatically
> exported through BTF and available to eBPF programs.
> 
> Also, add KEY_LOOKUP_ALL to the enum, with the logical OR of currently
> defined flags as value, to facilitate checking whether a variable contains
> only those flags.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  include/linux/key.h      | 6 ++++++
>  security/keys/internal.h | 2 --
>  2 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/key.h b/include/linux/key.h
> index 7febc4881363..d27477faf00d 100644
> --- a/include/linux/key.h
> +++ b/include/linux/key.h
> @@ -88,6 +88,12 @@ enum key_need_perm {
>  	KEY_DEFER_PERM_CHECK,	/* Special: permission check is deferred */
>  };
>  
> +enum key_lookup_flag {
> +	KEY_LOOKUP_CREATE = 0x01,
> +	KEY_LOOKUP_PARTIAL = 0x02,
> +	KEY_LOOKUP_ALL = (KEY_LOOKUP_CREATE | KEY_LOOKUP_PARTIAL),
> +};
> +
>  struct seq_file;
>  struct user_struct;
>  struct signal_struct;
> diff --git a/security/keys/internal.h b/security/keys/internal.h
> index 9b9cf3b6fcbb..3c1e7122076b 100644
> --- a/security/keys/internal.h
> +++ b/security/keys/internal.h
> @@ -165,8 +165,6 @@ extern struct key *request_key_and_link(struct key_type *type,
>  
>  extern bool lookup_user_key_possessed(const struct key *key,
>  				      const struct key_match_data *match_data);
> -#define KEY_LOOKUP_CREATE	0x01
> -#define KEY_LOOKUP_PARTIAL	0x02
>  
>  extern long join_session_keyring(const char *name);
>  extern void key_change_session_keyring(struct callback_head *twork);
> -- 
> 2.25.1
> 

Thanks,

Acked-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
