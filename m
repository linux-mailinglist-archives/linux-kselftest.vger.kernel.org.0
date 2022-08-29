Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 270895A43AC
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Aug 2022 09:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbiH2HWO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 29 Aug 2022 03:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbiH2HWM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 29 Aug 2022 03:22:12 -0400
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FFCA4DB7C;
        Mon, 29 Aug 2022 00:22:09 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4MGMGv3QbPz9v7HT;
        Mon, 29 Aug 2022 15:18:15 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwDHcJT1aAxjV_gHAA--.25494S2;
        Mon, 29 Aug 2022 08:21:40 +0100 (CET)
Message-ID: <cead9f6ad77a66425324a880bd1df389fe258d40.camel@huaweicloud.com>
Subject: Re: [PATCH v14 04/10] KEYS: Move KEY_LOOKUP_ to include/linux/key.h
 and add flags check function
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
Date:   Mon, 29 Aug 2022 09:25:05 +0200
In-Reply-To: <YwrpL9b3NXtjnPru@kernel.org>
References: <acae432697e854748d9a44c732ec8cab807d9d46.camel@huaweicloud.com>
         <20220826091228.1701185-1-roberto.sassu@huaweicloud.com>
         <6d85d7b1f0c2341698e88bad025bd6e0b34c7666.camel@huaweicloud.com>
         <YwroKjo7IkQDepp5@kernel.org> <YwrpL9b3NXtjnPru@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LxC2BwDHcJT1aAxjV_gHAA--.25494S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zw1rZw1fuw48JFW7JFW3GFg_yoW8GF1fpa
        48JayxKF4vyr13Ar92gFySyw1Fg397Wr1UXrn8Xr98uFnF9rnIyrs7Ga1S9Fyjgr4DK3Wq
        yFWjq343Zr17AaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgATBF1jj35fJgABsi
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, 2022-08-28 at 07:03 +0300, Jarkko Sakkinen wrote:
> On Sun, Aug 28, 2022 at 06:59:41AM +0300, Jarkko Sakkinen wrote:
> > On Fri, Aug 26, 2022 at 11:22:54AM +0200, Roberto Sassu wrote:
> > > On Fri, 2022-08-26 at 11:12 +0200, Roberto Sassu wrote:
> > > > From: Roberto Sassu <roberto.sassu@huawei.com>
> > > > 
> > > > In preparation for the patch that introduces the
> > > > bpf_lookup_user_key() eBPF
> > > > kfunc, move KEY_LOOKUP_ definitions to include/linux/key.h, to
> > > > be
> > > > able to
> > > > validate the kfunc parameters.
> > > > 
> > > > Also, introduce key_lookup_flags_valid() to check if the caller
> > > > set
> > > > in the
> > > > argument only defined flags. Introduce it directly in
> > > > include/linux/key.h,
> > > > to reduce the risk that the check is not in sync with currently
> > > > defined
> > > > flags.
> > > > 
> > > > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > > > Reviewed-by: KP Singh <kpsingh@kernel.org>
> > > 
> > > Jarkko, could you please ack it if it is fine?
> > 
> > So, as said I'm not really confident that a function is
> > even needed in the first place. It's fine if there are
> > enough call sites to make it legit.
> 
> And *if* a named constant is enough, you could probably
> then just squash to the same patch that uses it, right?

Yes, the constant seems better. Maybe, I would add in the same patch
that exports the lookup flags, since we have that.

Thanks

Roberto

