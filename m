Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 056E0185A3
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2019 09:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbfEIHAg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 May 2019 03:00:36 -0400
Received: from mail-wm1-f45.google.com ([209.85.128.45]:38492 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbfEIHAg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 May 2019 03:00:36 -0400
Received: by mail-wm1-f45.google.com with SMTP id f2so1653822wmj.3
        for <linux-kselftest@vger.kernel.org>; Thu, 09 May 2019 00:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:date:to:message-id:subject:mime-version;
        bh=nflwdImImUVz3CkxFWu9RdWR2XlFWOdGWI//YmvNq5k=;
        b=e1g8yv7TNTbYAzpt6AgD+ix5P0E0qqCuXMO6j8JefJMyV0C+6ke4Sq+bH0Y2p+4NDN
         EnQHjvN1alDkjObkXD5ATmaCk9qKjaODeMlEMvpknbdO4S5o9Nx5/hLCTZVVuR9I+MzB
         dSZMOLpM4w80459ymry14v96kl9wPWf+i8ElCVIzoqjmr41RGEDqyfWyW3Bs6DZJzRTk
         T3KSbUFiejGCX4OaMTdmPzpmF7vOJ7e7qzMPDIw+HQitWi36PAJywWuSNUWAsyhDjjR/
         kSlPYfVZ81JxoRtZiKAemAt9vPDSG2dscdjzu5eGIhakC0F0v5GwCYyNCFQdUiSyJ5St
         jB9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:message-id:subject:mime-version;
        bh=nflwdImImUVz3CkxFWu9RdWR2XlFWOdGWI//YmvNq5k=;
        b=DNzW8ba2SazHa7FeJlSOE8I0M8BtmHh5PIvFNdoTvXhGYS9ab4OQI8S13GrnJtQY+i
         MqOBWnGHYX8iqNAjeW0wsF7Ymexqyau8F363MXM37T8eLxN6EU+4tg1pYxgQitEtW/3z
         DhIX7kpOSqJHMUsxyQGNNxN4vedS/2jbaOhlR0i7AlZeEzfGEpkofK24qJo9KGIXl8C3
         Xo8fqVgr2utmef19LZo6NZmCGcxFkuREk6wpg5TC7jU25APCakHaFO8w9t2QjrsyD7eh
         OeOSkVtbSuUzkoAflW+CtUcsnixJExwok4Ax7cjuTzrRljrlgFrh+DKyXjac05dlwE4i
         PXRw==
X-Gm-Message-State: APjAAAW7DG4JYpnVPl4WnWEenfnXovA7nfdBpkvn3zQD06IvNDgmmcfu
        XZlQ4zTFv3lzd59jr0Et0Wi9e+1BSuk=
X-Google-Smtp-Source: APXvYqz/EmhpBdUYeBaPEdQx3DUUb/ipX4sjmln06Nj116ImdABNMRGmY1juoGoyW1dQbvD0/x5cnw==
X-Received: by 2002:a7b:c74e:: with SMTP id w14mr1473504wmk.19.1557385233748;
        Thu, 09 May 2019 00:00:33 -0700 (PDT)
Received: from a6c5c67cda76 (ci.linaro.org. [88.99.136.175])
        by smtp.gmail.com with ESMTPSA id q3sm1024094wrr.16.2019.05.09.00.00.32
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 09 May 2019 00:00:33 -0700 (PDT)
From:   ci_notify@linaro.org
X-Google-Original-From: linaro-infrastructure-errors@lists.linaro.org
Date:   Thu, 9 May 2019 07:00:32 +0000 (UTC)
To:     lkft-triage@lists.linaro.org, dan.rue@linaro.org,
        anders.roxell@linaro.org, naresh.kamboju@linaro.org,
        linux-kselftest@vger.kernel.org
Message-ID: <220118036.18068.1557385233047.JavaMail.jenkins@a6c5c67cda76>
Subject: next-20190509 kselftest results
MIME-Version: 1.0
Content-Type: multipart/mixed; 
        boundary="----=_Part_18067_360873165.1557385232604"
X-Jenkins-Job: LKFT Notify kselftest on next
X-Jenkins-Result: SUCCESS
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

------=_Part_18067_360873165.1557385232604
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Summary
------------------------------------------------------------------------
kernel: 5.1.0
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
git branch: master
git commit: unknown
git describe: next-20190509
Test details: https://qa-reports.linaro.org/lkft/linux-next-oe/build/next-20190509

Regressions (compared to build next-20190507)
------------------------------------------------------------------------
No regressions                                                                                                          
                                                                                                                       
Fixes (compared to build next-20190507)                                                                   
------------------------------------------------------------------------                                               
No fixes

In total:
------------------------------------------------------------------------
Ran 0 total tests in the following environments and test suites.
pass 0
fail 0
xfail 0
skip 0

Environments
--------------
- x15 - arm

Test Suites
-----------


Failures
------------------------------------------------------------------------

x15:


Skips
------------------------------------------------------------------------
No skips


-- 
Linaro LKFT
https://lkft.linaro.org
------=_Part_18067_360873165.1557385232604--
