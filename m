Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE39551F477
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 May 2022 08:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbiEIG2V (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 9 May 2022 02:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234457AbiEIGSC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 9 May 2022 02:18:02 -0400
X-Greylist: delayed 2285 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 08 May 2022 23:14:10 PDT
Received: from relay3.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A7CEAD27
        for <linux-kselftest@vger.kernel.org>; Sun,  8 May 2022 23:14:10 -0700 (PDT)
Received: from omf17.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay09.hostedemail.com (Postfix) with ESMTP id DA84C2FD39;
        Mon,  9 May 2022 05:36:03 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf17.hostedemail.com (Postfix) with ESMTPA id B49131E;
        Mon,  9 May 2022 05:36:01 +0000 (UTC)
Message-ID: <918affc0a0a91dab08647696ed6587021264f25f.camel@perches.com>
Subject: Re: [PATCH] KVM: selftests: riscv: Remove unneeded semicolon
From:   Joe Perches <joe@perches.com>
To:     Anup Patel <anup@brainfault.org>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        KVM General <kvm@vger.kernel.org>,
        linux-kselftest@vger.kernel.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Abaci Robot <abaci@linux.alibaba.com>
Date:   Sun, 08 May 2022 22:36:01 -0700
In-Reply-To: <CAAhSdy15CE5ZUROH-mOwhpR0AuwsK8h+8W-Kd0jxwsTixpQOQg@mail.gmail.com>
References: <20220506094512.116729-1-jiapeng.chong@linux.alibaba.com>
         <CAAhSdy15CE5ZUROH-mOwhpR0AuwsK8h+8W-Kd0jxwsTixpQOQg@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Stat-Signature: q34mkbymsd5c8i4guxezgn8qm5yedycu
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: B49131E
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        KHOP_HELO_FCRDNS,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.6
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/6eHbjh40QHHy98IswUgEhKu3HfsOuVzY=
X-HE-Tag: 1652074561-122139
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, 2022-05-09 at 10:37 +0530, Anup Patel wrote:
> On Fri, May 6, 2022 at 3:15 PM Jiapeng Chong
> <jiapeng.chong@linux.alibaba.com> wrote:
> > 
> > Fix the following coccicheck warnings:
> > 
> > ./tools/testing/selftests/kvm/lib/riscv/processor.c:353:3-4: Unneeded
> > semicolon.
> > 
> > Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> > Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> 
> In future, please CC kvm-riscv@lists.infradead.org for KVM RISC-V related
> patches.

Perhaps add or update some MAINTAINERS entry as this list is not
currently specified by:

$ ./scripts/get_maintainer.pl -f tools/testing/selftests/kvm/lib/riscv/processor.c --nogit --nogit-fallback
Paolo Bonzini <pbonzini@redhat.com> (supporter:KERNEL VIRTUAL MACHINE (KVM))
Shuah Khan <shuah@kernel.org> (maintainer:KERNEL SELFTEST FRAMEWORK)
Paul Walmsley <paul.walmsley@sifive.com> (supporter:RISC-V ARCHITECTURE)
Palmer Dabbelt <palmer@dabbelt.com> (supporter:RISC-V ARCHITECTURE)
Albert Ou <aou@eecs.berkeley.edu> (supporter:RISC-V ARCHITECTURE)
kvm@vger.kernel.org (open list:KERNEL VIRTUAL MACHINE (KVM))
linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK)
linux-riscv@lists.infradead.org (open list:RISC-V ARCHITECTURE)
linux-kernel@vger.kernel.org (open list)
$


