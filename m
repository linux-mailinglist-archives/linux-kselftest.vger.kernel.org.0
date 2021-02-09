Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49192314D49
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Feb 2021 11:43:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbhBIKjg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 9 Feb 2021 05:39:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231213AbhBIKg7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 9 Feb 2021 05:36:59 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29CE2C061786
        for <linux-kselftest@vger.kernel.org>; Tue,  9 Feb 2021 02:36:04 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id k22so5135032pll.6
        for <linux-kselftest@vger.kernel.org>; Tue, 09 Feb 2021 02:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hollensbe-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:content-transfer-encoding:date:message-id:cc:subject
         :from:to:references:in-reply-to;
        bh=x6sNNOwBbVuaklXDW5qltjHb3nTUzjynYK+5iDFadaQ=;
        b=b10kif6ay6aZiLGIxdWHSuLpT9DeHjn70tlO0feYUYAe9hi54fQZGoChUchnQukaV6
         WkQGXmY+K+aT+exYTd5MNwLyDetzFPpdBD80HkgRwcMAVBZRgwIno9Z6Uf5xiXVBh9Ov
         9+71EHe4ZQr88lYdPAqouRspjI5c3RKDFTQwnAUP7Nq10RvHJUfwwLCHsagamb8uvVUx
         s5vTi2oL1kVkcUQQrdQPHNVQiAFtQsAiXjecpUQ9ml+UqhnE/I5Gsm+d2a+qIV92VNwh
         ofQwxLqAfq1YviBwAI+Yltb/rEH6vD2m8V5sGvg8UOwbJLg1uwsTxguqGuth4daRRHB+
         Uvzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:date
         :message-id:cc:subject:from:to:references:in-reply-to;
        bh=x6sNNOwBbVuaklXDW5qltjHb3nTUzjynYK+5iDFadaQ=;
        b=CJHpCMt5DMeZHAWceBcakVDchN8j/T28TCm3R6xquFMsTczKfgGUTIRYHJRvqZ0X0E
         ebbPCbLYThv2Ap/qXLy5fxkTncvfmjkTUWfwPRVr0RpWf4SDRctwtr669AHNXwJXW9SL
         Hth7G0mKnnRnnOJUUjar+LHg9RkfpmF1h8puEXbySNUCrFb5YICaoOTx2fzLTLgGCxJ2
         GdhHV6V6s6v6MZ/tzGzUVr98St1gGfqwi4Qy15rz0PGLpJE9O5OV44dywCRyD9cWh4jF
         hDBNspPbwy7bKO3nR9V9wAtZaMnyNombW0h2bWNe6O564Zpph63XfoxsTBLRBnms/VqO
         AbXA==
X-Gm-Message-State: AOAM530GkWeyK76ENJA24uRhDShjhkMPl734QhSj7p96YNIWLaNLf9ua
        YJ/mi+eKkxKrWCO3+UZ4zhwOGcwskwOATw==
X-Google-Smtp-Source: ABdhPJyE1lO/2OvXbuN+AeYbLwql59jrT74sYRpdYSNnERh9ef+ZOz1f/FvNTXiv0/nRIeDH6t4OKw==
X-Received: by 2002:a17:90a:2ec7:: with SMTP id h7mr3372337pjs.200.1612866963777;
        Tue, 09 Feb 2021 02:36:03 -0800 (PST)
Received: from localhost ([104.220.82.74])
        by smtp.gmail.com with ESMTPSA id o21sm2017993pjp.42.2021.02.09.02.36.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 09 Feb 2021 02:36:03 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 09 Feb 2021 02:36:01 -0800
Message-Id: <C94XMDHN14ZS.18ZHFT92LZRVJ@comms>
Cc:     <shuah@kernel.org>
Subject: Re: [PATCH] Correct leftover directories from make kselftest
From:   "Erik Hollensbe" <linux@hollensbe.org>
To:     "Shuah Khan" <skhan@linuxfoundation.org>,
        "Erik Hollensbe" <erik@hollensbe.org>,
        <linux-kselftest@vger.kernel.org>
References: <20210128033743.77040-1-erik@hollensbe.org>
 <20210128033743.77040-2-erik@hollensbe.org>
 <aadb7d9c-6042-0b4e-9d2a-764432ccf0ef@linuxfoundation.org>
In-Reply-To: <aadb7d9c-6042-0b4e-9d2a-764432ccf0ef@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon Feb 8, 2021 at 4:17 PM PST, Shuah Khan wrote:
> Thank you for the patch.
>
> Can you split these into two patches? make separate patches for gpio
> and timens.
>
> Gives you more practice. :)

I sent one for gpio; under a different email address (this one), it does
reference the initial patch, however.

Hope that works. Thanks for letting me practice! :D

-Erik
