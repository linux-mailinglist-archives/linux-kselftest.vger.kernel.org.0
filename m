Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79BAF5ADAE8
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Sep 2022 23:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232292AbiIEVi6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 5 Sep 2022 17:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbiIEVi5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 5 Sep 2022 17:38:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC384459A6;
        Mon,  5 Sep 2022 14:38:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3DD7C60BEB;
        Mon,  5 Sep 2022 21:38:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19B92C433C1;
        Mon,  5 Sep 2022 21:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662413935;
        bh=cZo+nBDWscuk91kBYX2XhmZN6ePZTsV8K5UeyA4xrmk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cQziaopxhGVv009umQpUpd8obSATqKfY9NnDXhX1q5uPKlpurRFh1idZ/CFMVXywu
         12WYc2CtCq1obyDoDsDUGh/qpD5+g2fKTvS6EztF7rLzb/wDNIZNEn5erCImUgAJLO
         qAIXMmX1AsvmHXwgIuKwx8mnb9pqi8MnVmmT2EMiyJZ7Ks0zHj4MMtvM+UnNYwi8yU
         yxGftCzVy2u+X7jnYcyRyLNwOYc23YGAxs9TMwSX5S1imL25UaiakAbs39ANBjNSKA
         VhGLo/hI66bNKaScLgd7OFrJAc34aQ8jFNTblKexe+sTT1RvqkoLXWhhlsz+gBwJZr
         QEfaxmIqiSkTw==
Date:   Tue, 6 Sep 2022 00:38:52 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
        dhowells@redhat.com, rostedt@goodmis.org, mingo@redhat.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        shuah@kernel.org, bpf@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        deso@posteo.net, memxor@gmail.com,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: Re: [PATCH v16 05/12] KEYS: Move KEY_LOOKUP_ to include/linux/key.h
 and define KEY_LOOKUP_ALL
Message-ID: <YxZsbLIAcR4/bScc@kernel.org>
References: <20220905143318.1592015-1-roberto.sassu@huaweicloud.com>
 <20220905143318.1592015-6-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220905143318.1592015-6-roberto.sassu@huaweicloud.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Sep 05, 2022 at 04:33:11PM +0200, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
> 
> In preparation for the patch that introduces the bpf_lookup_user_key() eBPF
> kfunc, move KEY_LOOKUP_ definitions to include/linux/key.h, to be able to
> validate the kfunc parameters. Add them to enum key_lookup_flag, so that
> all the current ones and the ones defined in the future are automatically
> exported through BTF and available to eBPF programs.
> 
> Also, add KEY_LOOKUP_ALL to the enum, to facilitate checking whether a
> variable contains only defined flags.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Reviewed-by: KP Singh <kpsingh@kernel.org>
> Acked-by: Jarkko Sakkinen <jarkko@kernel.org>

You should remove ack if there is any substantial change.

> ---
>  include/linux/key.h      | 6 ++++++
>  security/keys/internal.h | 2 --
>  2 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/key.h b/include/linux/key.h
> index 7febc4881363..d84171f90cbd 100644
> --- a/include/linux/key.h
> +++ b/include/linux/key.h
> @@ -88,6 +88,12 @@ enum key_need_perm {
>  	KEY_DEFER_PERM_CHECK,	/* Special: permission check is deferred */
>  };
>  
> +enum key_lookup_flag {
> +	KEY_LOOKUP_CREATE = 0x01,	/* Create special keyrings if they don't exist */
> +	KEY_LOOKUP_PARTIAL = 0x02,	/* Permit partially constructed keys to be found */
> +	KEY_LOOKUP_ALL = (KEY_LOOKUP_CREATE | KEY_LOOKUP_PARTIAL), /* OR of previous flags */

Drop the comments (should be reviewed separately + out of context).

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

BR, Jarkko
