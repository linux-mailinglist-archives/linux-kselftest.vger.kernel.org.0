Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE19FC1CF
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2019 09:47:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726057AbfKNIrt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 14 Nov 2019 03:47:49 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40619 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbfKNIrs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 14 Nov 2019 03:47:48 -0500
Received: by mail-lf1-f65.google.com with SMTP id j26so4355081lfh.7
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Nov 2019 00:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=Fm4cgskO7xAtTVrqH1BFUqnNfZpTIAGunhMGmIZW7/s=;
        b=TN39mF4nR35JtFm0whkw7+oks46zhE32UjqNJZVgFIfm2CioG3rpFIY6VVS/OR4ZPe
         Bh/gA9bYQuszxouKL+WS8I4ThJTK2QKxocEeH4fwYO3Qhp/0aihBhaQRLmM7Cmpm5jj+
         ycXaxAwhmwhRPETdzSW66meln/xbxNddYo7M2Y+q1SbUagFN9GbY76bcd/tmPRuv84rs
         EC/zZ9Xkhk5+tS1W5zlCCoj2NLl7wM8M8TAlf71m9yvxKZTPTnJZ4ayHj53QHfKkg2VP
         BRlWbD2KlObIijeowoQArlnnZwSujiBfP/o0/VnhnLfeSmaJTf3oAid6uy6lsCfeIu7y
         eCNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=Fm4cgskO7xAtTVrqH1BFUqnNfZpTIAGunhMGmIZW7/s=;
        b=jOiIKn2gubkzQhIzfI+vQ5lycRvYQflDxWwW8JPMFZO4X4/7RJqJyHWLVJUcb+f9rX
         rb+G4CsvccvYGe2hL5PNVGgF4kfT/uUtjt3FLPqtLbUAkFZsmoJchwsFkDXticvQTIay
         EQ04io21W1x/AELe5Q4Z53YGcdgb0fAzghHvHEheIhcCLQe+/4gUcXyyRf4KecrJGIXm
         eCHRrdbFicBInZcpJ9jsbclq9L+lG5ovxKlD2ZpEifl5Qk+DDcAj2mClwSluW7btK5gH
         nZdgX4wvrQ7Z2rk2scnScIznCzjaUqRTqTLr68MTL+MI4rAD6C/fg314qisgT0DZqkWj
         9wRA==
X-Gm-Message-State: APjAAAUED7/8JqK8OtbN7UTwiJNH7U6ebvQ7lHnpPxYzb8uGEBkErQks
        2k2nP0UZLPyDTe2W1tmfOSAnUdraw1uy2eDdL0SfOhOpSz0=
X-Google-Smtp-Source: APXvYqys1Y1h3MHYkjo5uaPKewSsiFyuAjEYY3aphEjNA66bzAHnvvFundH0r15k5BA4/6LwCmcvfSjRt9YoOaPqnhQ=
X-Received: by 2002:a19:e018:: with SMTP id x24mr5785690lfg.191.1573721266204;
 Thu, 14 Nov 2019 00:47:46 -0800 (PST)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 14 Nov 2019 14:17:34 +0530
Message-ID: <CA+G9fYsmZOf9zgo5dy2_HfPPK-0tBYfCXpZy2DneFOeiJfN=_g@mail.gmail.com>
Subject: selftest/net: so_txtime.sh fails intermittently - read Resource
 temporarily unavailable
To:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, Netdev <netdev@vger.kernel.org>
Cc:     Shuah Khan <shuah@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        lkft-triage@lists.linaro.org,
        Willem de Bruijn <willemb@google.com>,
        "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

selftests net so_txtime.sh fails intermittently on multiple boards and
linux next and mainline.


# selftests net so_txtime.sh
net: so_txtime.sh_ #
#
: _ #
# SO_TXTIME ipv6 clock monotonic
ipv6: clock_monotonic #
# payloada delay452 expected0 (us)
delay452: expected0_(us) #
#
: _ #
# SO_TXTIME ipv4 clock monotonic
ipv4: clock_monotonic #
# payloada delay97 expected0 (us)
delay97: expected0_(us) #
#
: _ #
# SO_TXTIME ipv6 clock monotonic
ipv6: clock_monotonic #
# payloada delay168 expected0 (us)
delay168: expected0_(us) #
#
: _ #
# SO_TXTIME ipv4 clock monotonic
ipv4: clock_monotonic #
# payloada delay90 expected0 (us)
delay90: expected0_(us) #
#
: _ #
# SO_TXTIME ipv6 clock monotonic
ipv6: clock_monotonic #
# payloada delay10146 expected10000 (us)
delay10146: expected10000_(us) #
#
: _ #
# SO_TXTIME ipv4 clock monotonic
ipv4: clock_monotonic #
# payloada delay10146 expected10000 (us)
delay10146: expected10000_(us) #
#
: _ #
# SO_TXTIME ipv6 clock monotonic
ipv6: clock_monotonic #
# payloada delay10261 expected10000 (us)
delay10261: expected10000_(us) #
# payloadb delay20211 expected20000 (us)
delay20211: expected20000_(us) #
#
: _ #
# SO_TXTIME ipv4 clock monotonic
ipv4: clock_monotonic #
# payloada delay10186 expected10000 (us)
delay10186: expected10000_(us) #
# payloadb delay20387 expected20000 (us)
delay20387: expected20000_(us) #
#
: _ #
# SO_TXTIME ipv6 clock monotonic
ipv6: clock_monotonic #
# payloadb delay20238 expected20000 (us)
delay20238: expected20000_(us) #
# payloada delay20294 expected20000 (us)
delay20294: expected20000_(us) #
#
: _ #
# SO_TXTIME ipv4 clock monotonic
ipv4: clock_monotonic #
# payloadb delay20258 expected20000 (us)
delay20258: expected20000_(us) #
# payloada delay20313 expected20000 (us)
delay20313: expected20000_(us) #
#
: _ #
# SO_TXTIME ipv6 clock tai
ipv6: clock_tai #
# ./so_txtime read Resource temporarily unavailable
read: Resource_temporarily #
#
: _ #
# SO_TXTIME ipv6 clock tai
ipv6: clock_tai #
# ./so_txtime read Resource temporarily unavailable
read: Resource_temporarily #
#
: _ #
# SO_TXTIME ipv6 clock tai
ipv6: clock_tai #
# payloada delay10097 expected10000 (us)
delay10097: expected10000_(us) #
#
: _ #
# SO_TXTIME ipv4 clock tai
ipv4: clock_tai #
# payloada delay9957 expected10000 (us)
delay9957: expected10000_(us) #
#
: _ #
# SO_TXTIME ipv6 clock tai
ipv6: clock_tai #
# payloada delay10382 expected10000 (us)
delay10382: expected10000_(us) #
# ./so_txtime read Resource temporarily unavailable
read: Resource_temporarily #
[FAIL] 24 selftests net so_txtime.sh # exit=1
selftests: net_so_txtime.sh [FAIL]

Test run full log,
https://lkft.validation.linaro.org/scheduler/job/1010545#L1234

Test results comparison link,
https://qa-reports.linaro.org/lkft/linux-next-oe/tests/kselftest/net_so_txtime.sh
https://qa-reports.linaro.org/lkft/linux-mainline-oe/tests/kselftest/net_so_txtime.sh

Best regards
Naresh Kamboju
