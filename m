Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44D375AE093
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Sep 2022 09:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233490AbiIFHJU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Sep 2022 03:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233428AbiIFHJS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Sep 2022 03:09:18 -0400
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBFD562A98;
        Tue,  6 Sep 2022 00:09:13 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4MMGZP1d3Cz9v7QZ;
        Tue,  6 Sep 2022 15:03:41 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwBX0lzs8RZjHR0nAA--.22279S2;
        Tue, 06 Sep 2022 08:08:43 +0100 (CET)
Message-ID: <394ed3b5f96afd3cf39e99675be1a32c89c8080d.camel@huaweicloud.com>
Subject: Re: [PATCH v16 05/12] KEYS: Move KEY_LOOKUP_ to include/linux/key.h
 and define KEY_LOOKUP_ALL
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
Date:   Tue, 06 Sep 2022 09:08:23 +0200
In-Reply-To: <YxZsbLIAcR4/bScc@kernel.org>
References: <20220905143318.1592015-1-roberto.sassu@huaweicloud.com>
         <20220905143318.1592015-6-roberto.sassu@huaweicloud.com>
         <YxZsbLIAcR4/bScc@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: GxC2BwBX0lzs8RZjHR0nAA--.22279S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AF15JryDWFyfXF47Ww15Jwb_yoW8uF17pF
        WkJ3WFkr18JryxAwn7G3Wayw1rta9xKr17XFZ2gw1kZayFqr1vgrn7GF4a9F1FyrWq9F42
        9rW7uF1Uua1DArJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAHBF1jj4KlcQADsm
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 2022-09-06 at 00:38 +0300, Jarkko Sakkinen wrote:
> On Mon, Sep 05, 2022 at 04:33:11PM +0200, Roberto Sassu wrote:
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
> > Also, add KEY_LOOKUP_ALL to the enum, to facilitate checking
> > whether a
> > variable contains only defined flags.
> > 
> > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > Reviewed-by: KP Singh <kpsingh@kernel.org>
> > Acked-by: Jarkko Sakkinen <jarkko@kernel.org>
> 
> You should remove ack if there is any substantial change.

Yes, sorry. I thought you were fine with the change due to:

https://lore.kernel.org/bpf/YxF4H9MTDj+PnJ+V@kernel.org/

> 
> > ---
> >  include/linux/key.h      | 6 ++++++
> >  security/keys/internal.h | 2 --
> >  2 files changed, 6 insertions(+), 2 deletions(-)
> > 
> > diff --git a/include/linux/key.h b/include/linux/key.h
> > index 7febc4881363..d84171f90cbd 100644
> > --- a/include/linux/key.h
> > +++ b/include/linux/key.h
> > @@ -88,6 +88,12 @@ enum key_need_perm {
> >  	KEY_DEFER_PERM_CHECK,	/* Special: permission check is
> > deferred */
> >  };
> >  
> > +enum key_lookup_flag {
> > +	KEY_LOOKUP_CREATE = 0x01,	/* Create special keyrings if they
> > don't exist */
> > +	KEY_LOOKUP_PARTIAL = 0x02,	/* Permit partially constructed
> > keys to be found */
> > +	KEY_LOOKUP_ALL = (KEY_LOOKUP_CREATE | KEY_LOOKUP_PARTIAL), /*
> > OR of previous flags */
> 
> Drop the comments (should be reviewed separately + out of context).

The same style is used for many definitions in include/linux/key.h

No problem to remove them, please just let me know where they should
be. Often, eBPF maintainers asked me to add a description to the code
to explain how new definitions should be used.

Thanks

Roberto

