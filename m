Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DDEB5AE82E
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Sep 2022 14:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233111AbiIFMcE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Sep 2022 08:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240224AbiIFMbb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Sep 2022 08:31:31 -0400
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD27AF2E;
        Tue,  6 Sep 2022 05:29:41 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4MMPh837Wmz9v7Nk;
        Tue,  6 Sep 2022 20:24:08 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwA3ZV8KPRdjOwYoAA--.51363S2;
        Tue, 06 Sep 2022 13:29:12 +0100 (CET)
Message-ID: <455d80a39b2bf87c58dae9b6035f8cabb4455639.camel@huaweicloud.com>
Subject: Re: [PATCH v17 05/12] KEYS: Move KEY_LOOKUP_ to include/linux/key.h
 and define KEY_LOOKUP_ALL
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     kpsingh@kernel.org
Cc:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, deso@posteo.net, dhowells@redhat.com,
        haoluo@google.com, jmorris@namei.org, john.fastabend@gmail.com,
        jolsa@kernel.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org, martin.lau@linux.dev,
        memxor@gmail.com, mingo@redhat.com, mykolal@fb.com,
        paul@paul-moore.com, roberto.sassu@huawei.com, rostedt@goodmis.org,
        sdf@google.com, serge@hallyn.com, shuah@kernel.org,
        song@kernel.org, yhs@fb.com, Jarkko Sakkinen <jarkko@kernel.org>
Date:   Tue, 06 Sep 2022 14:28:55 +0200
In-Reply-To: <Yxc8fwOgZ+UY0jiX@kernel.org>
References: <YxcyeZBHGPNQB+qJ@kernel.org>
         <20220906121506.165001-1-roberto.sassu@huaweicloud.com>
         <Yxc8fwOgZ+UY0jiX@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: GxC2BwA3ZV8KPRdjOwYoAA--.51363S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw1ftr15Xw4UZF1fZFyfXrb_yoW8tFy8pF
        WDG3W8KryUtry2gw1DJwsFyw1Sk3y3Kr17WrnrKwn8Zana9r97tr1xtF13ur1FyrWUuw12
        qr4293WDur4DA3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkIb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1S6rWUM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8C
        rVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4
        IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCF04k20xvY
        0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I
        0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAI
        cVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0x
        vE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E
        87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IUbHa0PUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAHBF1jj36rwAABsk
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 2022-09-06 at 15:26 +0300, Jarkko Sakkinen wrote:
> On Tue, Sep 06, 2022 at 02:15:06PM +0200, Roberto Sassu wrote:
> > From: Roberto Sassu <roberto.sassu@huawei.com>
> > 
> > In preparation for the patch that introduces the
> > bpf_lookup_user_key() eBPF
> > kfunc, move KEY_LOOKUP_ definitions to include/linux/key.h, to be
> > able to
> > validate the kfunc parameters. Add them to enum key_lookup_flag, so
> > that
> > all the current ones and the ones defined in the future are
> > automatically
> > exported through BTF and available to eBPF programs.
> > 
> > Also, add KEY_LOOKUP_ALL to the enum, with the logical OR of
> > currently
> > defined flags as value, to facilitate checking whether a variable
> > contains
> > only those flags.
> > 
> > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > ---
> >  include/linux/key.h      | 6 ++++++
> >  security/keys/internal.h | 2 --
> >  2 files changed, 6 insertions(+), 2 deletions(-)
> > 
> > diff --git a/include/linux/key.h b/include/linux/key.h
> > index 7febc4881363..d27477faf00d 100644
> > --- a/include/linux/key.h
> > +++ b/include/linux/key.h
> > @@ -88,6 +88,12 @@ enum key_need_perm {
> >  	KEY_DEFER_PERM_CHECK,	/* Special: permission check is
> > deferred */
> >  };
> >  
> > +enum key_lookup_flag {
> > +	KEY_LOOKUP_CREATE = 0x01,
> > +	KEY_LOOKUP_PARTIAL = 0x02,
> > +	KEY_LOOKUP_ALL = (KEY_LOOKUP_CREATE | KEY_LOOKUP_PARTIAL),
> > +};
> > +
> >  struct seq_file;
> >  struct user_struct;
> >  struct signal_struct;
> > diff --git a/security/keys/internal.h b/security/keys/internal.h
> > index 9b9cf3b6fcbb..3c1e7122076b 100644
> > --- a/security/keys/internal.h
> > +++ b/security/keys/internal.h
> > @@ -165,8 +165,6 @@ extern struct key *request_key_and_link(struct
> > key_type *type,
> >  
> >  extern bool lookup_user_key_possessed(const struct key *key,
> >  				      const struct key_match_data
> > *match_data);
> > -#define KEY_LOOKUP_CREATE	0x01
> > -#define KEY_LOOKUP_PARTIAL	0x02
> >  
> >  extern long join_session_keyring(const char *name);
> >  extern void key_change_session_keyring(struct callback_head
> > *twork);
> > -- 
> > 2.25.1
> > 
> 
> Thanks,
> 
> Acked-by: Jarkko Sakkinen <jarkko@kernel.org>

Thanks Jarkko.

KP, ok also for you?

Thanks

Roberto

