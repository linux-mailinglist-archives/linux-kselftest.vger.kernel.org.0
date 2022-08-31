Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6CB5A7A1E
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Aug 2022 11:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231453AbiHaJYP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 31 Aug 2022 05:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231604AbiHaJYL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 31 Aug 2022 05:24:11 -0400
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73BB057231;
        Wed, 31 Aug 2022 02:24:08 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4MHdrw2BnPz9v7Ts;
        Wed, 31 Aug 2022 17:18:40 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwA34JOPKA9jgTwQAA--.40239S2;
        Wed, 31 Aug 2022 10:23:40 +0100 (CET)
Message-ID: <cad9a20cadc074cf15dcd0d8eb63b43c98a2f13d.camel@huaweicloud.com>
Subject: Re: [PATCH v14 05/12] KEYS: Move KEY_LOOKUP_ to include/linux/key.h
 and set KEY_LOOKUP_FLAGS_ALL
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>
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
Date:   Wed, 31 Aug 2022 11:23:25 +0200
In-Reply-To: <Yw7o43Ivfo3jRwQg@kernel.org>
References: <20220830161716.754078-1-roberto.sassu@huaweicloud.com>
         <20220830161716.754078-6-roberto.sassu@huaweicloud.com>
         <Yw7NKJfhyJqIWUcx@kernel.org> <Yw7o43Ivfo3jRwQg@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LxC2BwA34JOPKA9jgTwQAA--.40239S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uF4xGF1kWrWrAFWDZFy3XFb_yoW8Kr4DpF
        yDGF1jkr1Utry3WwnFganIy3WxK39xtr12gr90gwnYqFsaqryxKr12gF15uF1F9rW7uw4I
        vr42ganxuryDA3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1S6rWUM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26r4j6r4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI
        7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
        Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY
        6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcV
        CF04k26cxKx2IYs7xG6Fyj6rWUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
        6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUOlksDUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQABBF1jj4J04wAAsg
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 2022-08-31 at 07:51 +0300, Jarkko Sakkinen wrote:
> On Wed, Aug 31, 2022 at 05:53:28AM +0300, Jarkko Sakkinen wrote:
> > On Tue, Aug 30, 2022 at 06:17:09PM +0200, Roberto Sassu wrote:
> > > From: Roberto Sassu <roberto.sassu@huawei.com>
> > > 
> > > In preparation for the patch that introduces the
> > > bpf_lookup_user_key() eBPF
> > > kfunc, move KEY_LOOKUP_ definitions to include/linux/key.h, to be
> > > able to
> > > validate the kfunc parameters.
> > > 
> > > Also, define the new constant KEY_LOOKUP_FLAGS_ALL, to facilitate
> > > checking
> > > whether a variable contains only defined flags.
> > > 
> > > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > > Reviewed-by: KP Singh <kpsingh@kernel.org>
> > > ---
> > >  include/linux/key.h      | 4 ++++
> > >  security/keys/internal.h | 2 --
> > >  2 files changed, 4 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/include/linux/key.h b/include/linux/key.h
> > > index 7febc4881363..e2a70e0fa89f 100644
> > > --- a/include/linux/key.h
> > > +++ b/include/linux/key.h
> > > @@ -88,6 +88,10 @@ enum key_need_perm {
> > >  	KEY_DEFER_PERM_CHECK,	/* Special: permission check is deferred
> > > */
> > >  };
> > >  
> > > +#define KEY_LOOKUP_CREATE	0x01
> > > +#define KEY_LOOKUP_PARTIAL	0x02
> > > +#define KEY_LOOKUP_FLAGS_ALL	(KEY_LOOKUP_CREATE |
> > > KEY_LOOKUP_PARTIAL)
> > 
> > IMHO this could be just KEY_LOOKUP_ALL.
> > 
> > > +
> > >  struct seq_file;
> > >  struct user_struct;
> > >  struct signal_struct;
> > > diff --git a/security/keys/internal.h b/security/keys/internal.h
> > > index 9b9cf3b6fcbb..3c1e7122076b 100644
> > > --- a/security/keys/internal.h
> > > +++ b/security/keys/internal.h
> > > @@ -165,8 +165,6 @@ extern struct key
> > > *request_key_and_link(struct key_type *type,
> > >  
> > >  extern bool lookup_user_key_possessed(const struct key *key,
> > >  				      const struct key_match_data
> > > *match_data);
> > > -#define KEY_LOOKUP_CREATE	0x01
> > > -#define KEY_LOOKUP_PARTIAL	0x02
> > >  
> > >  extern long join_session_keyring(const char *name);
> > >  extern void key_change_session_keyring(struct callback_head
> > > *twork);
> > > -- 
> > > 2.25.1
> > > 
> > 
> > Other than that wfm.
> 
> Roberto, with the change done above, just add my ack
> to the next version:
> 
> Acked-by: Jarkko Sakkinen <jarkko@kernel.org>
> 

Perfect, thanks.

Roberto

