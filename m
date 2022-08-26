Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 705C15A2187
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Aug 2022 09:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244863AbiHZHPF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 26 Aug 2022 03:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233000AbiHZHPE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 26 Aug 2022 03:15:04 -0400
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A59963B2;
        Fri, 26 Aug 2022 00:14:55 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4MDWDD2JYwz9v7Gl;
        Fri, 26 Aug 2022 15:09:32 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwCXUhrFcghjHMlQAA--.57474S2;
        Fri, 26 Aug 2022 08:14:27 +0100 (CET)
Message-ID: <acae432697e854748d9a44c732ec8cab807d9d46.camel@huaweicloud.com>
Subject: Re: [PATCH v12 04/10] KEYS: Move KEY_LOOKUP_ to include/linux/key.h
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
        corbet@lwn.net, dhowells@redhat.com, rostedt@goodmis.org,
        mingo@redhat.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, shuah@kernel.org, bpf@vger.kernel.org,
        linux-doc@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        deso@posteo.net, Roberto Sassu <roberto.sassu@huawei.com>
Date:   Fri, 26 Aug 2022 09:14:09 +0200
In-Reply-To: <YwhTiGOhzvv+CYYq@kernel.org>
References: <20220818152929.402605-1-roberto.sassu@huaweicloud.com>
         <20220818152929.402605-5-roberto.sassu@huaweicloud.com>
         <YwhTiGOhzvv+CYYq@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: GxC2BwCXUhrFcghjHMlQAA--.57474S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KF15tryxWrWrCrWkXr15CFg_yoW8ur1DpF
        W8G3Wj9F18Cry7A3s3JwnFyw1agrs7Gr17Xr9xWwn5ZanIqrn2qrn2gF15uFy5CrW09w1I
        qFWjga17ur1UA3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1S6rWUM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UAkuxUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAQBF1jj35RKQAAsh
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 2022-08-26 at 08:42 +0300, Jarkko Sakkinen wrote:
> On Thu, Aug 18, 2022 at 05:29:23PM +0200, 
> roberto.sassu@huaweicloud.com wrote:
> > From: Roberto Sassu <roberto.sassu@huawei.com>
> > 
> > In preparation for the patch that introduces the
> > bpf_lookup_user_key() eBPF
> > kfunc, move KEY_LOOKUP_ definitions to include/linux/key.h, to be
> > able to
> > validate the kfunc parameters.
> > 
> > Also, introduce key_lookup_flags_check() directly in
> > include/linux/key.h,
> > to reduce the risk that the check is not in sync with currently
> > defined
> > flags.
> 
> Missing the description what the heck this function even is.
> 
> Please, explain that.

Hi Jarkko

sorry, forgot to update the commit description. Will do it.

> Also, the short subject is misleading because this *just*
> does not move flags.
> 
> > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > Reviewed-by: KP Singh <kpsingh@kernel.org>
> > ---
> >  include/linux/key.h      | 11 +++++++++++
> >  security/keys/internal.h |  2 --
> >  2 files changed, 11 insertions(+), 2 deletions(-)
> > 
> > diff --git a/include/linux/key.h b/include/linux/key.h
> > index 7febc4881363..b5bbae77a9e7 100644
> > --- a/include/linux/key.h
> > +++ b/include/linux/key.h
> > @@ -88,6 +88,17 @@ enum key_need_perm {
> >  	KEY_DEFER_PERM_CHECK,	/* Special: permission check is
> > deferred */
> >  };
> >  
> > +#define KEY_LOOKUP_CREATE	0x01
> > +#define KEY_LOOKUP_PARTIAL	0x02
> > +
> 
> /*
>  * Explain what the heck this function is.
>  */
> > +static inline int key_lookup_flags_check(u64 flags)
> > +{
> > +	if (flags & ~(KEY_LOOKUP_CREATE | KEY_LOOKUP_PARTIAL))
> > +		return -EINVAL;
> > +
> > +	return 0;
> > +}
> 
> This is essentially a boolean function, right?
> 
> I.e. the implementation can be just:
> 
> !!(flags & ~(KEY_LOOKUP_CREATE | KEY_LOOKUP_PARTIAL))

Absolutely fine with that, if you prefer.

> Not even sure if this is needed in the first place, or
> would it be better just to open code it. How many call
> sites does it have anyway?
> 

Daniel preferred to have this check here.

Thanks

Roberto

