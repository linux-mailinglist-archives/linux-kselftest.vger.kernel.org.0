Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E59E1859A8
	for <lists+linux-kselftest@lfdr.de>; Sun, 15 Mar 2020 04:28:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbgCOD2F (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 14 Mar 2020 23:28:05 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41620 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbgCOD2F (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 14 Mar 2020 23:28:05 -0400
Received: by mail-qt1-f193.google.com with SMTP id i26so1484010qtq.8
        for <linux-kselftest@vger.kernel.org>; Sat, 14 Mar 2020 20:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bFsKuiep4ClLWNIwvV7dTX+4w75us5hu5B1lo4Fci+w=;
        b=LIHXtFoMK4jkPn13923WHP00ZP321fe642FYhyZH5RiTKEg42E6CsLIqLPMLtXN853
         YVka50hLwilG/LutVffmM4eqGfP0WibwBtBCSnd1XBeAQx2Vc36hwjr8d+HNPAUcit5P
         YO+/vlmsRih91vCK+rypmMKBv/T/zQYKBKx0F5A1vKuAp2nnj505HI6BPZsPswX9YQzL
         4mxuxLVCdzsSAyul/A0kPQ8pW4sB0/XsypxuVl94A91Vk8xbiEbkzbIoKjhuoA5Z0T5q
         ILHZ3VXfSxEMlpvksyERvwhUg0UOXm4TEfGZXYvXqlF/M4BnlawKBGQCIMLQ3w2AxVTN
         yhcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bFsKuiep4ClLWNIwvV7dTX+4w75us5hu5B1lo4Fci+w=;
        b=mvC3k14ht8RNaZ4sdIj3EP8BCuGlqBYOiPtPUsgxcZ+FkKoYb5hPgTfHKKLaERRrT5
         LYKw9RemMf59RNGfeBT5PPf7byUTlbioRizfmT1oy6kmaJyl1j1KcjC/BUvpzvnxYjhk
         WbfAr7ApEKO5budBtd6upEd3lawo8LBzoD1oH/jAU+vHETnMaYUCN61meXSbromOjz2j
         EPbk7Q+CzrlZUqsJqdh52bkpocWT323/13CWy/d1n+yNDxQOVl8kisapSnNGtlzAIUNp
         YBfoKPIHnm2zfPQ0QQwmnfe/A7b/4LmP7BijluzoqHzZXt5wVOodnPoti8UInVpZe5zS
         Zgcw==
X-Gm-Message-State: ANhLgQ0/VnRyxiDfYBt9wpYM6D0L2g4GjPTmtxu4o6lqduNrCWXHfPu7
        p6mBCoEMc1bzpOiXch6wmLn+liOzv+k=
X-Google-Smtp-Source: ADFU+vsPu03tHI/dFTUfh/sYeeKb1eTqZGkbcU9vpsVwCD8k9ULECXU2SUDsc+Dq2tqNzZCGPGyhTg==
X-Received: by 2002:aed:234a:: with SMTP id i10mr19704478qtc.155.1584242882749;
        Sat, 14 Mar 2020 20:28:02 -0700 (PDT)
Received: from dhcp-12-139.nay.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id 207sm14356921qkf.69.2020.03.14.20.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2020 20:28:02 -0700 (PDT)
Date:   Sun, 15 Mar 2020 11:27:56 +0800
From:   Hangbin Liu <liuhangbin@gmail.com>
To:     shuah <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH 0/1] selftests/run_kselftest.sh: make each test
 individually selectable
Message-ID: <20200315032756.GD2159@dhcp-12-139.nay.redhat.com>
References: <20200309101256.868-1-liuhangbin@gmail.com>
 <632a1803-cc62-7d54-69ca-88fc13d72966@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <632a1803-cc62-7d54-69ca-88fc13d72966@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Mar 13, 2020 at 01:42:52PM -0600, shuah wrote:
> Hi Hangbin,
> 
> On 3/9/20 4:12 AM, Hangbin Liu wrote:
> > Hi, this patch enhanced the run_kselftest.sh to make the tests individually
> > selectable. I'm not sure the if I could add the reuslt in the patch commit,
> > as the log is too long. So I just put the result to the cover-letter:
> > 
> > Note: I use `tr -s "/-" "_"` to cover the path name in tests to function name.
> > e.g. networking/timestamping -> networking_timestamping. I'm not sure if it's
> > legal in Makefile.
> 
> 
> Please add this to the patch change log. Please run get_maintainers
> script before sending the patch. My email address you used is very
> old.
> 
> Please include how to run and update the documentation as well.

OK, I will, thanks for the feedback and sorry for the inconvenient.

Regards
Hangbin
