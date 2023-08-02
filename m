Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9739676D84D
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Aug 2023 22:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbjHBUAt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Aug 2023 16:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbjHBUAs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Aug 2023 16:00:48 -0400
X-Greylist: delayed 501 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 02 Aug 2023 13:00:46 PDT
Received: from out-68.mta1.migadu.com (out-68.mta1.migadu.com [95.215.58.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B10E2101
        for <linux-kselftest@vger.kernel.org>; Wed,  2 Aug 2023 13:00:46 -0700 (PDT)
Date:   Wed, 2 Aug 2023 19:52:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1691005942;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hm3oxgB8rWWmmLgRhUOJv7kBA627iWO/DBEx4711DtQ=;
        b=tmNgkfGFRR9HC750nyR8v12fuZWaFZsq9GlFGNMIRlFE2Unkf0lHoo6K8HwivWN/JcS/FG
        TGqvrqGL6+HlG0aY0e7JWzmHvf3sq+oya4RVRqOTbDIFiLufgI4meqC9xxTFGTOEyCbnwp
        KXEqidowRPXrrf1Q5ry0HKewIq7KOY0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Oliver Upton <oliver.upton@linux.dev>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Bibo Mao <maobibo@loongson.cn>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: selftests: use unified time type for comparison
Message-ID: <ZMqz8UHBvJXs8vnw@linux.dev>
References: <20230731022405.854884-1-maobibo@loongson.cn>
 <ZMqu43iUfA/LsxlD@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZMqu43iUfA/LsxlD@google.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Howdy,

On Wed, Aug 02, 2023 at 12:30:43PM -0700, Sean Christopherson wrote:
> On Mon, Jul 31, 2023, Bibo Mao wrote:
> > With test case kvm_page_table_test, start time is acquired with
> > time type CLOCK_MONOTONIC_RAW, however end time in function timespec_elapsed
> > is acquired with time type CLOCK_MONOTONIC. This will cause
> > inaccurate elapsed time calculation on some platform such as LoongArch.

Well, there's the fundamental issue of mixing to timebases, so this
really isn't platform specific. One is subject to NTP frequency
adjustments and the other is not.

> > This patch modified test case kvm_page_table_test, and uses unified
> > time type CLOCK_MONOTONIC for start time.
> 
> AFAICT, there's zero reason to use CLOCK_MONOTONIC_RAW instead of CLOCK_MONOTONIC.
> If there are no objections, I'll take this through kvm-x86/selftests for 6.6.

CLOCK_MONOTONIC is objectively the better choice if you want something
that accurately tracks wall time, which we certainly do. So yeah, fine
by me to take this through the x86 tree:

Reviewed-by: Oliver Upton <oliver.upton@linux.dev>

-- 
Thanks,
Oliver
