Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5764848CBA1
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jan 2022 20:12:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356913AbiALTMH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Jan 2022 14:12:07 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:37160 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356618AbiALTLD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Jan 2022 14:11:03 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id D22501F453B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1642014661;
        bh=ubIbtXQ1srjhhZkCWaAUTsQRTCKpUd7QlzP6ZpRxxWQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HL1786ePLgEJgkDu6ZP9kU8MNf6z3KGXPVwIKqN5n30Yrw2G3yjX6CHt0ujeGgkBV
         i+GKHB8jta7NizChnpKgyzma4mbnTgtjdRwp8GPRnp9SsEFM4RWk8AeNLyTgW79fxD
         1cT1L6O6e89GWWI2bKx2YKELelr0DhQiZNbc0fTc+VmzdamVDqX21QvfSA18M+fFIj
         0vDchsoRcSJuQsym7AdLl6wACLuDXBeEecbXkrMMyiWZFTyuO0rHNFPMvDSHRX+KKQ
         2gc3OwRJRkBUDCCnjvbE6DINCYK+ddD6VMOx33rZTw/UCHHOP2sd+/syyTyP4Roq5N
         GhYjF8wZqg4HA==
Date:   Wed, 12 Jan 2022 14:10:56 -0500
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Shuah Khan <shuah@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rtc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH] selftests: rtc: Increase test timeout so that all tests
 run
Message-ID: <20220112191056.c7gflbokgm2pispg@notapiano>
References: <20220112165359.3206047-1-nfraprado@collabora.com>
 <Yd8IdbGybWBOa5qe@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Yd8IdbGybWBOa5qe@piout.net>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jan 12, 2022 at 05:57:25PM +0100, Alexandre Belloni wrote:
> On 12/01/2022 11:53:59-0500, Nícolas F. R. A. Prado wrote:
> > The timeout setting for the rtc kselftest is currently 90 seconds.
> > However, two of the tests set alarms, which take one minute to complete
> > each. So the timeout should be at least 120. Set it to 180, so that all
> > tests are able to complete and still have some slack.
> 
> Hum, I don't get the logic from that, a test takes up to 60 seconds and
> the timeout is 90s per test so we already have plenty of slack there.

Actually I did re-test locally and it is an issue since the 90s timeout is not
per-test, but to the whole rtc test suite. Also it requires running the test
through the selftest runner, and since the alarm is set to the next top of the
minute, you might get lucky and it might all take less than 90 seconds.

However none of this was clear in my original commit message, so I'll send a v2
with a better explanation.

Thanks,
Nícolas
