Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42E0E6CBA1B
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Mar 2023 11:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbjC1JHn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 28 Mar 2023 05:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjC1JHn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 28 Mar 2023 05:07:43 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B94104ED1;
        Tue, 28 Mar 2023 02:07:38 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Pm3jd2thwz4wj7;
        Tue, 28 Mar 2023 20:07:33 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1679994453;
        bh=CI6UkVt1iNphqH6yIerjhQUaBQ8iiEe/qQHit4JlIMo=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=HyVQaSrNlh7ULd1z7j7TqAGwSq+AIBMp2CM4ASQ7RpsS8yuBSbS4xwXn60fRG3hZH
         ry6Dgzy72rZ3epcrMLSJ+xxvGMeNkGCYSXrKUIxv2+UrTkX3a9IOy4He8x8QJ5KTkO
         LxV04GU8KDSOLoDbtxIWwYdinbAVgz3FPmPj039LD+W1Q3p1FfertasEgTNtTGD8sz
         rw8thPH4tGKiLr36IgisfD+PMsRJ/VUva3Jf1bounNv/NA0ePr647Is1fmOKlWSF8k
         sC1VCebtZEGyxxWwvC+znGT2JjkipULl8TbCbMjpRojrWXpFYMt3Llqc2dcC/ZOziJ
         kTp7CuaDe9ZQA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Nicholas Piggin <npiggin@gmail.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 0/2] KVM: PPC: support kvm selftests
In-Reply-To: <CRHTDZZU72CJ.3QAHM67MV5G47@bobo>
References: <20230316031732.3591455-1-npiggin@gmail.com>
 <87ilf0nc95.fsf@mpe.ellerman.id.au> <ZBs9tGkI5OQqtIqs@google.com>
 <CRGX867PJCBF.1MV46YLYXMBYZ@bobo> <ZCHV20oFkFzp/AZs@google.com>
 <CRHTDZZU72CJ.3QAHM67MV5G47@bobo>
Date:   Tue, 28 Mar 2023 20:07:29 +1100
Message-ID: <87tty5ckha.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

"Nicholas Piggin" <npiggin@gmail.com> writes:
> On Tue Mar 28, 2023 at 3:43 AM AEST, Sean Christopherson wrote:
>> On Mon, Mar 27, 2023, Nicholas Piggin wrote:
>> > On Thu Mar 23, 2023 at 3:41 AM AEST, Sean Christopherson wrote:
...
>> > >
>> > > What is the long term plan for KVM PPC maintenance?  I was under the impression
>> > > that KVM PPC was trending toward "bug fixes only", but the addition of selftests
>> > > support suggests otherwise.
...
>
>> and ideally there would be one or more M: (and R:) entries as well.  I'm not
>> all that concerned about the selftests support being abandoned, but the lack of
>> specific contacts makes it look like KVM PPC is in maintenance-only mode, and it
>> sounds like that's not the case.
>
> Yeah, I guess the intention was to bring it a bit more under general
> arch/powerpc maintainership but it does look a bit odd having a top
> level entry and no contacts. We'll reconsider what to do with that.

Yeah I agree it ends up looking a bit weird.

The intention was just to make it clear that Paul's tree was no longer
where patches were being handled, and that they'd be handled as regular
powerpc patches.

At the time I hoped we'd relatively quickly be able to add someone as at
least a KVM "R:"eviewer, but circumstances intervened.

Hopefully we can fix that soon.

cheers
