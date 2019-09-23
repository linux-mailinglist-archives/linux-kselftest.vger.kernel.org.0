Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DAEE6BBC57
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Sep 2019 21:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728267AbfIWTn3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 23 Sep 2019 15:43:29 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39486 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728181AbfIWTn3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 23 Sep 2019 15:43:29 -0400
Received: by mail-wr1-f67.google.com with SMTP id r3so15314155wrj.6;
        Mon, 23 Sep 2019 12:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ltPYUxFooOhed88EBLtldCYWPv0nxqna9LT7y/vhHOU=;
        b=mujarN8aF/SeAzAKIU/93Xr8lcOtSx/iIkwtF4zYsMPUndWPBgxpvCTBMz66n7vM0u
         /jXMNl/fP2LSbS8hjRLooB5a8EOw09SjRkLMTTqmoWt292wegxX7f1XOB2aDnUWuZcL8
         6g76kKEkacecmPbDMkC/CisE2RHXnN8PA0ZUpE925MWPh469TVO2rDtYy83jJ/XyQZR3
         TDTt8OYj7oicDYxmp1Us9hMfLHiT2gT/v6xeJDOY4PkBOlaoz+NGj8K3PEKG6bPpq8DJ
         UWb1luBSinwwxRQSw14nvdQHzc9RC6+T9A10mGs9b8MKmeJTBVpiw+aKMIeAhojEMkHn
         B+4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ltPYUxFooOhed88EBLtldCYWPv0nxqna9LT7y/vhHOU=;
        b=ZKV793Rt5Q4GGkSzSEd56B8q7JSXRXTN9QBFhctIawCy4NBZ7+GE412/FIR0VjLn8p
         yAmkeJlarJ69bMgkVK/g0BUD/93UYoBrKb6Arv5dg7Uz9og6NLoXZjdTaIOH2wYS8GGl
         15q9RncTL4/gsk156M8n0BmVFIBsNL5UtGE7JHRhvKOsNeFN/xEAhkhiUFNA8JsYzmKF
         9FCuN7T+gu0kMhI1bsFAbhvgbTt8kV0dFiDIejlFLtsifLsYk/edwR58nQvf3EEd+OIw
         JHdD6iGLN5nQ6BdUkeHQnS4Sxps19+FYzdYm8HTcYoQ9TFBOzHiyhuobTe39lcCt0Xfq
         qXcg==
X-Gm-Message-State: APjAAAXvppjghuam5UsxkPL91f6AwtUzgGjn4k0Cs/1i1KOhg8w/w1HR
        J1ilBkXTjjecK4QhmUmHvp0=
X-Google-Smtp-Source: APXvYqyn4x52E3p+WymflXE2LT2U4YUXdHiN4rlb8xOXSC69QvGXwDbVsCbw7cgDvEdlzFWvY3c9MQ==
X-Received: by 2002:adf:cf0c:: with SMTP id o12mr797873wrj.30.1569267805107;
        Mon, 23 Sep 2019 12:43:25 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id m16sm11232098wml.11.2019.09.23.12.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2019 12:43:24 -0700 (PDT)
Date:   Mon, 23 Sep 2019 21:43:22 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Mark Brown <broonie@kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] Kselftest update for Linux 5.4-rc1
Message-ID: <20190923194322.GA55255@gmail.com>
References: <be8059f4-8e8f-cd18-0978-a9c861f6396b@linuxfoundation.org>
 <CAHk-=wgs+UoZWfHGENWSVBd57Z-Vp0Nqe68R6wkDb5zF+cfvDg@mail.gmail.com>
 <CAKRRn-edxk9Du70A27V=d3Na73fh=fVvGEVsQRGROrQm05YRrA@mail.gmail.com>
 <CAFd5g45ROPm-1SD5cD772gqESaP3D8RbBhSiJXZzbaA+2hFdHA@mail.gmail.com>
 <CAHk-=wgMuNLBhJR_nFHrpViHbz2ErQ-fJV6B9o0+wym+Wk+r0w@mail.gmail.com>
 <20190922112555.GB122003@gmail.com>
 <20190922115247.GA2679387@kroah.com>
 <0ab5da69-e4f2-8990-20f9-354461235581@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ab5da69-e4f2-8990-20f9-354461235581@linuxfoundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


* Shuah Khan <skhan@linuxfoundation.org> wrote:

> I am exploring the possibility to move selftests to a better location 
> or add a git alias so it can be found easily. With the addition of 
> KUnit and future work that is planned to connect kselftest and KUnit, 
> it would make sense have selftests to be in a location that is better 
> suited than where it currently resides.
> 
> I have been getting feedback from some developers that they would like 
> to see selftests more visible and easier to find.
> 
> There are some dependencies (unintended, shouldn't exist) between some 
> tests and content under tools that might pose some logistical problems, 
> in addition to the churn of backporting.
> 
> I haven't explored "git alias" yet though. Since this topic of moving 
> came up, I would liek to get feedback on selftests location in general 
> and where would be a good place for it.

I'm not sure about the Git alias thing - but I do agree that 
tools/testing/selftests is a pretty obscure location given the importance 
of kernel unit tests - and I think it could be moved one level higher, to 
tools/selftests? The "selftest" name already implies the "test" aspect 
after all.

Thanks,

	Ingo
