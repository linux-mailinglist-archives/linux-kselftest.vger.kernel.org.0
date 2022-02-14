Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18D554B4E8A
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Feb 2022 12:34:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351478AbiBNLdy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Feb 2022 06:33:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351552AbiBNLdn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Feb 2022 06:33:43 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08CBB6623F;
        Mon, 14 Feb 2022 03:19:06 -0800 (PST)
Date:   Mon, 14 Feb 2022 12:19:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644837544;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TUCDizit6LTXe+/Z7T4+9bqxe+YJSMfI2IhU/DVOtKY=;
        b=TJuYP9SxAH4EcWDpm6XCS+R8gN3OgxWiK4tgjHkGVvYymALEsSgIduBlSJJ1qH9ItVOp1/
        HUGLsLiybl53Fip90qHs2BcaiMWrGtrAzOHsEe2xfg5vBIe4+mb62vtHXqe10JvJT5XMbm
        Z9z0NDAN/42Ie16SsgmxkFKyB1AZvCWQSkPgWYbTSrbhqQfs6wIHqVZMQuiNlrczg0LhAR
        hNbwjIk5l5TggackMIqZQehE95dNkxdMJJD61kDalHtkO7drqJckUhrjPoVFY/TioWLhXD
        kg7uTqSCfPjx+bwk68FQT1VRlGeI+53kWTENOgGfilF+9iqywqdwE7WJDw+4oA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644837544;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TUCDizit6LTXe+/Z7T4+9bqxe+YJSMfI2IhU/DVOtKY=;
        b=wnRWctoS8b6dZ6CVHS04P744Fy8jgvdjeIbzBT/reAMI6H2rRDMpfm4yH0kwbtiW6ytm2u
        LKIcFdCKAdT3UNAg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org, joseph.salisbury@canonical.com,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v3] selftests/ftrace: Do not trace do_softirq because of
 PREEMPT_RT
Message-ID: <Ygo6pqWmkTWJNNcR@linutronix.de>
References: <20220214083657.165921-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220214083657.165921-1-krzysztof.kozlowski@canonical.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2022-02-14 09:36:57 [+0100], Krzysztof Kozlowski wrote:
> The PREEMPT_RT patchset does not use do_softirq() function thus trying
> to filter for do_softirq fails for such kernel:
>=20
>   echo do_softirq
>   ftracetest: 81: echo: echo: I/O error
>=20
> Choose some other visible function for the test.  The function does not
> have to be actually executed during the test, because it is only testing
> filter API interface.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
> Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

> Notes:
> I understand that the failure does not exist on mainline kernel (only
> with PREEMPT_RT patchset) but the change does not harm it.

Yes, and now it does not sound (to me) like duct tape. Thank you.

> If it is not suitable alone, please consider it for RT patchset.

We trying to get it merged so=E2=80=A6

Sebastian
