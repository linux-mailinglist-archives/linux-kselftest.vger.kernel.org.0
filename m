Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1B75A2430
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Aug 2022 11:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343625AbiHZJXo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 26 Aug 2022 05:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245405AbiHZJXo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 26 Aug 2022 05:23:44 -0400
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D8719DF8C;
        Fri, 26 Aug 2022 02:23:42 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4MDZ4n5G6Hz9v7Gy;
        Fri, 26 Aug 2022 17:18:17 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwCHVxPykAhjEntOAA--.37856S2;
        Fri, 26 Aug 2022 10:23:12 +0100 (CET)
Message-ID: <6d85d7b1f0c2341698e88bad025bd6e0b34c7666.camel@huaweicloud.com>
Subject: Re: [PATCH v14 04/10] KEYS: Move KEY_LOOKUP_ to include/linux/key.h
 and add flags check function
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
        corbet@lwn.net, dhowells@redhat.com, jarkko@kernel.org,
        rostedt@goodmis.org, mingo@redhat.com, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com, shuah@kernel.org
Cc:     bpf@vger.kernel.org, linux-doc@vger.kernel.org,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        deso@posteo.net, Roberto Sassu <roberto.sassu@huawei.com>
Date:   Fri, 26 Aug 2022 11:22:54 +0200
In-Reply-To: <20220826091228.1701185-1-roberto.sassu@huaweicloud.com>
References: <acae432697e854748d9a44c732ec8cab807d9d46.camel@huaweicloud.com>
         <20220826091228.1701185-1-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LxC2BwCHVxPykAhjEntOAA--.37856S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uF1DurWrJFWxtFWxJF4kXrb_yoW8Kr13pF
        yDCFyFkryUCFy7W3s3GanIya1Sg3yrGr17Cr9xWwn09Fsag3y8tr1kGF15WF15CrWUuw1j
        qr42ga15ur1DA3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkIb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1S6rWUM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8C
        rVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4
        IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCF04k20xvY
        0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I
        0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAI
        cVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0x
        vE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E
        87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU1ebytUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAQBF1jj35StQAAs+
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 2022-08-26 at 11:12 +0200, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
> 
> In preparation for the patch that introduces the
> bpf_lookup_user_key() eBPF
> kfunc, move KEY_LOOKUP_ definitions to include/linux/key.h, to be
> able to
> validate the kfunc parameters.
> 
> Also, introduce key_lookup_flags_valid() to check if the caller set
> in the
> argument only defined flags. Introduce it directly in
> include/linux/key.h,
> to reduce the risk that the check is not in sync with currently
> defined
> flags.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Reviewed-by: KP Singh <kpsingh@kernel.org>

Jarkko, could you please ack it if it is fine?

Thanks

Roberto

> ---
>  include/linux/key.h      | 16 ++++++++++++++++
>  security/keys/internal.h |  2 --
>  2 files changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/key.h b/include/linux/key.h
> index 7febc4881363..e679dbf0c940 100644
> --- a/include/linux/key.h
> +++ b/include/linux/key.h
> @@ -88,6 +88,22 @@ enum key_need_perm {
>  	KEY_DEFER_PERM_CHECK,	/* Special: permission check is
> deferred */
>  };
>  
> +#define KEY_LOOKUP_CREATE	0x01
> +#define KEY_LOOKUP_PARTIAL	0x02
> +
> +/**
> + * key_lookup_flags_valid - detect if provided key lookup flags are
> valid
> + * @flags: key lookup flags.
> + *
> + * Verify whether or not the caller set in the argument only defined
> flags.
> + *
> + * Return: true if flags are valid, false if not.
> + */
> +static inline bool key_lookup_flags_valid(u64 flags)
> +{
> +	return !(flags & ~(KEY_LOOKUP_CREATE | KEY_LOOKUP_PARTIAL));
> +}
> +
>  struct seq_file;
>  struct user_struct;
>  struct signal_struct;
> diff --git a/security/keys/internal.h b/security/keys/internal.h
> index 9b9cf3b6fcbb..3c1e7122076b 100644
> --- a/security/keys/internal.h
> +++ b/security/keys/internal.h
> @@ -165,8 +165,6 @@ extern struct key *request_key_and_link(struct
> key_type *type,
>  
>  extern bool lookup_user_key_possessed(const struct key *key,
>  				      const struct key_match_data
> *match_data);
> -#define KEY_LOOKUP_CREATE	0x01
> -#define KEY_LOOKUP_PARTIAL	0x02
>  
>  extern long join_session_keyring(const char *name);
>  extern void key_change_session_keyring(struct callback_head *twork);

