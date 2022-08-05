Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96D4D58B017
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Aug 2022 20:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241020AbiHESzr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 5 Aug 2022 14:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236448AbiHESzq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 5 Aug 2022 14:55:46 -0400
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [IPv6:2a0c:5a00:149::26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BD42DF53
        for <linux-kselftest@vger.kernel.org>; Fri,  5 Aug 2022 11:55:44 -0700 (PDT)
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
        by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <mhal@rbox.co>)
        id 1oK2U1-003cGR-5M
        for linux-kselftest@vger.kernel.org; Fri, 05 Aug 2022 20:55:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
        s=selector1; h=Message-Id:In-Reply-To:Date:Subject:CC:To:From:MIME-Version:
        Content-Transfer-Encoding:Content-Type;
        bh=Re2VYOmUvCPJIl2+PrIKUcavLpF01PTLx7a9jzfSfHY=; b=IJ4RSb0ufgyOQ+YFh9ycQX/J4I
        SfdZMZuhEUaZiVD+oA8GYGkUddYmaXzUoPRyVyrJffSeJIJjWqAFw+sB/DE9MX1r8aGOpR/CFId4I
        vD7JX1V0C5/nmZJ2vdb2hndQ7+DSml4q0Ep4vBv9B3WjXY/4Hlt6PB5RMwlWutVbwzFjw83xfvKtj
        CcQ6K9Fwd6raA4RVz4+WezUcVIwJbpw9yRzqVFa/ZqnXqliY/m2fpLX7VsG0l4XierP8rkkSJT8Jv
        B71w9nrzCvgeXeVVHH/q2YqqzHrXKCUlF7tujbRshzV4VYpR63/7LyTbSVF/i48o8v9JHkl8AhXiE
        qqBcnf7w==;
Received: from [10.9.9.127] (helo=rmmprod05.runbox)
        by mailtransmit02.runbox with esmtp (Exim 4.86_2)
        (envelope-from <mhal@rbox.co>)
        id 1oK2U0-00041Z-E0; Fri, 05 Aug 2022 20:55:40 +0200
Received: from mail by rmmprod05.runbox with local (Exim 4.86_2)
        (envelope-from <mhal@rbox.co>)
        id 1oK2U0-0000qn-CI; Fri, 05 Aug 2022 20:55:40 +0200
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Received: from [Authenticated alias (604044)] by runbox.com with http
 (RMM6); Fri, 05 Aug 2022 18:55:40 GMT
From:   "Michal Luczaj" <mhal@rbox.co>
To:     "Paolo Bonzini" <pbonzini@redhat.com>
CC:     "Sean Christopherson" <seanjc@google.com>,
        "kvm" <kvm@vger.kernel.org>, "shuah" <shuah@kernel.org>,
        "linux-kselftest" <linux-kselftest@vger.kernel.org>
Subject: Re: [kvm-unit-tests PATCH 2/4] x86: emulator.c cleanup: Use
 ASM_TRY for the UD_VECTOR cases
Date:   Fri, 05 Aug 2022 20:55:40 +0200 (CEST)
X-RMM-Aliasid: 604044
X-Mailer: RMM6
In-Reply-To: <ae0a0049-8db0-501b-79e4-cd32758156fb@redhat.com>
Message-Id: <E1oK2U0-0000qn-CI@rmmprod05.runbox>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 5 Aug 2022 13:42:40 +0200, Paolo Bonzini <pbonzini@redhat.com> wrot=
e:
> On 8/3/22 20:21, Sean Christopherson wrote:
> >> I've noticed test_illegal_movbe() does not execute with KVM_FEP.
> >> Just making sure: is it intentional?
> > It's intentional.  FEP isn't needed because KVM emulates MOVBE on #UD w=
hen it's
> > not supported by the host, e.g. to allow migrating to an older host.
> >=20
> > 	GP(EmulateOnUD | ModRM, &three_byte_0f_38_f0),
> > 	GP(EmulateOnUD | ModRM, &three_byte_0f_38_f1),
> >=20
>=20
> *puts historian hat on*
>=20
> The original reason was to test Linux using MOVBE even on non-Atom=20
> machines, when MOVBE was only on Atoms. :)

So the emulator's logic for MOVBE is meant to be tested only when the
guest supports MOVBE while the host does not?

Michal
