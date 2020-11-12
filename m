Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65A2C2B0B6E
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Nov 2020 18:40:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbgKLRk5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 Nov 2020 12:40:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbgKLRk5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 Nov 2020 12:40:57 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D97FC0613D1
        for <linux-kselftest@vger.kernel.org>; Thu, 12 Nov 2020 09:40:57 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id z3so5183528pfb.10
        for <linux-kselftest@vger.kernel.org>; Thu, 12 Nov 2020 09:40:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:user-agent:mime-version;
        bh=jDydBGIQZBbt3PYBnnFtjaDUNOST7q6PVKkVO3Vu+O4=;
        b=y44WsHFSXBeqaRVe8ItfEORvCHna5VuJOV3vTVg2uCFu5z/U9Tg4acMMgpwwHq7+r+
         1feyE9S6obALerJCnCRjqAYi1GxzHmfhz4W3WYGlvyMVhSoGN8nO64viq7pensfA0JKP
         74Mt46ylJ/syxyCZrGal0JddWF0+xHTTBMMQS+HWMZres2odMgpc+ovwpPRYhbe+31ob
         i9Cw21L0sdn8GWI5UIq6kh7++InLwqqnjT5IZKOUhFCxDpIUrtiv701VbecLGuz4ypTK
         mamDdsiWf6xLMCKTHWdFhfwiCzaPI6789y8BpLWYqYS8JQckTHnlCjgIL0bF8IQhl08R
         AYYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:user-agent
         :mime-version;
        bh=jDydBGIQZBbt3PYBnnFtjaDUNOST7q6PVKkVO3Vu+O4=;
        b=H/hIOh+pYUB7n6fOavp5t3+6exzZmjuAYNcPmIkk5C9yrpsqnLRU27UkBEvuR9M1Pi
         ojHIrFR70giPy3EnvW4MCUXWoZPJBrFkKCRjQ3xZpfSf12EKMsSb75MKA3tqLiE2uooP
         HAHfERIzNY0+tzAEnbjdaphgxFm1xxi8ZPf5Pp6hV7OkBhuDP1/1o1tN3QCSGOs3EHkw
         vG85+S071fqjvbxF+NyTv0c13Zo4f3hot/xADiVjaqrIxkT2fjbJ9YPzNXUoUXIYogN9
         8+ukXRRdZc6KeeRnjEsSY7riiZEoXCvolXDKFwWYtCFL2ZO2BJPsdFBB2HzCN1YeFXYi
         r6NQ==
X-Gm-Message-State: AOAM531WusysxyaQ1pkUCj82CXJjHmHAXO5AEX1dXkRq21Y6n5FJIRnQ
        /ThcHRJaYMQVp6tSMwV2luc+VQ==
X-Google-Smtp-Source: ABdhPJzHsiHuD2NB7eAcaZd9tAGV50JlBeDs3Ioo6mTZp5ezx4w0ttRJFPxKdyEVDKSOAfnIOD3G4Q==
X-Received: by 2002:a17:90b:180f:: with SMTP id lw15mr258280pjb.119.1605202856777;
        Thu, 12 Nov 2020 09:40:56 -0800 (PST)
Received: from debian ([122.164.29.50])
        by smtp.gmail.com with ESMTPSA id j1sm6960397pfa.96.2020.11.12.09.40.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 09:40:55 -0800 (PST)
Message-ID: <2ea637f38be0d03d0e0c545a6d12f36217cededc.camel@rajagiritech.edu.in>
Subject: checking  for "config" file existence.
From:   Jeffrin Jose T <jeffrin@rajagiritech.edu.in>
To:     Shuah Khan <shuah@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Date:   Thu, 12 Nov 2020 23:10:47 +0530
Content-Type: multipart/mixed; boundary="=-PX2PTFLhggBF/OB5QKfj"
User-Agent: Evolution 3.36.4-2 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--=-PX2PTFLhggBF/OB5QKfj
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

hello,

i wrote a  small program to check for the existence of "config" files
for testing projects under kselftest framework.

chmod 755 test_config.py
This file should be located in "tools/testing/selftests"
This can be run as "./test_config.py"



-- 
software engineer
rajagiri school of engineering and technology - autonomous




--=-PX2PTFLhggBF/OB5QKfj
Content-Disposition: attachment; filename="test_config.py"
Content-Type: text/x-python3; name="test_config.py"; charset="UTF-8"
Content-Transfer-Encoding: base64

IyEvdXNyL2Jpbi9weXRob24zCiMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAKIyBD
b3B5cmlnaHQgKEMpIDIwMjAgIFJTRVQKCmltcG9ydCBvcwpmcm9tIHBhdGhsaWIgaW1wb3J0IFBh
dGgKCm9rID0gMApub3RvayA9IDAKZm9yIGZpbGVuYW1lIGluIG9zLmxpc3RkaXIoKToKICAgIGZp
bGVhbGwgPSBQYXRoKCIuLyIrZmlsZW5hbWUpCiAgICBmaWxlY2hlY2sgPSBQYXRoKCIuLyIrZmls
ZW5hbWUrIi8iKyJjb25maWciKQogICAgaWYgKGZpbGVhbGwuaXNfZGlyKCkpIGFuZCAoZmlsZW5h
bWUgIT0gImtzZWxmdGVzdCIpOgogICAgICAgIGlmIGZpbGVjaGVjay5leGlzdHMoKToKICAgICAg
ICAgICAgcHJpbnQoZmlsZW5hbWUsIiBbUEFTU11cbiIpCiAgICAgICAgICAgIG9rID0gb2sgKyAx
IAogICAgICAgIGVsc2U6CiAgICAgICAgICAgIHByaW50KGZpbGVuYW1lLCIgW0ZBSUxdXG4iKQog
ICAgICAgICAgICBub3RvayA9IG5vdG9rICsgMQoKcHJpbnQob2srbm90b2ssIlRFU1RFRCIpIApw
cmludChvaywgIlBBU1NFRCIpCnByaW50KG5vdG9rLCJGQUlMRUQiKQo=


--=-PX2PTFLhggBF/OB5QKfj--

