Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3865FBBD59
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Sep 2019 22:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387785AbfIWUxb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 23 Sep 2019 16:53:31 -0400
Received: from mail-wm1-f54.google.com ([209.85.128.54]:51206 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387617AbfIWUxb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 23 Sep 2019 16:53:31 -0400
Received: by mail-wm1-f54.google.com with SMTP id 7so11501751wme.1;
        Mon, 23 Sep 2019 13:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mTa4bZT/5UrHG0lWADElPHHf/xGZTHN6ndQmHlpfS98=;
        b=sduTLnFAc8Xd8b24ZwUXyRsIbyE9Kff7ORVmVe+3u08R7QFEthD6oVOIfccdH4/7BX
         8jUgSssdJV0dIRNyqJeoFV+h0PkD1Bpjsk99MlvQW1/+ND7ewA0KtFyJQd9MAviTgU8T
         7IRO8GB/HGOUqZMTA3Ldjn4P9yYyrjr1OMA1K4OtimxMrhGpjIhoPSnFm6h5/H8noUQ6
         KJDUVhmCMrgFGXqU5nk+oMyiMY3TIjqfmub1VS22Qt/P+baD1n4CcKQ/f3qpvNe0UTEo
         1pxM5Q/L3hyJOQ6VGoOKrlbgEfVjfZcMXa+ZqhpQqElbRUsMAHkkk4AbW2UcilEHR68C
         eqUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=mTa4bZT/5UrHG0lWADElPHHf/xGZTHN6ndQmHlpfS98=;
        b=Ox9z1rM70qaeQgPPtn3vI42+5Zp8xBZYxvm2UCa+8hD0ROcB6ymc4HOF4FlPGMzTDL
         /gpp/OV1DCVhuFUFigGOaaiszL6gbwVYmKz87rVcRpbyYgQMaJzFrXF8MGJouYDG2Noc
         zQJ2/TATmV6Z2cRDf7ER39ZYOzpPRFPaR3me0ms1fK1UT5HPlutcQ/qJg+aE1kVATfM7
         Fu2fqTkVYQOa433pX0y1mulBMaPAgMg1AQbyt+V1nUBY8DtKrELmdc13HP7N1LmhYpl2
         AxtzQ1fUGdt3xZ1zfkKrP6B38kSS9q0xGcUAMFSs6aYnJ2gE7eAwhfNsIcK9YpgQHPIQ
         Efmw==
X-Gm-Message-State: APjAAAUrqPUv/luFXB0QHyylvd1WgEYtVXoqGj7VAgAtmjzY7IztM4u0
        nnA4uuwpRFf3BD3z1r9RUMI=
X-Google-Smtp-Source: APXvYqz6PxZpcewnWl0zFX3VSkSGm3xom7Nm87NBpfbP6nUQxaM5SoCLc94oNzQLuIUdeOUnTrS7lw==
X-Received: by 2002:a05:600c:110a:: with SMTP id b10mr564127wma.18.1569272008807;
        Mon, 23 Sep 2019 13:53:28 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id d78sm16630690wmd.47.2019.09.23.13.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2019 13:53:27 -0700 (PDT)
Date:   Mon, 23 Sep 2019 22:53:25 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Mark Brown <broonie@kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] Kselftest update for Linux 5.4-rc1
Message-ID: <20190923205325.GA121000@gmail.com>
References: <CAHk-=wgs+UoZWfHGENWSVBd57Z-Vp0Nqe68R6wkDb5zF+cfvDg@mail.gmail.com>
 <CAKRRn-edxk9Du70A27V=d3Na73fh=fVvGEVsQRGROrQm05YRrA@mail.gmail.com>
 <CAFd5g45ROPm-1SD5cD772gqESaP3D8RbBhSiJXZzbaA+2hFdHA@mail.gmail.com>
 <CAHk-=wgMuNLBhJR_nFHrpViHbz2ErQ-fJV6B9o0+wym+Wk+r0w@mail.gmail.com>
 <20190922112555.GB122003@gmail.com>
 <20190922115247.GA2679387@kroah.com>
 <0ab5da69-e4f2-8990-20f9-354461235581@linuxfoundation.org>
 <20190923194322.GA55255@gmail.com>
 <32d0e94d-bf9a-01e9-2548-1fc976c7f17b@infradead.org>
 <f4c21702-f7b5-e6f9-b31d-8fc9e4d1c67d@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f4c21702-f7b5-e6f9-b31d-8fc9e4d1c67d@linuxfoundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


* Shuah Khan <skhan@linuxfoundation.org> wrote:

> Right. What you suggesting is very similar to and more complete than 
> what I have been thinking about and proposed at the KS kselftest track.
> 
> i.e move tools/testing/selftests to kselftest at the root level. I like 
> your idea of moving tools/testing up to root and keep selftests under 
> it.
> 
> If we are good with this kind of change, I would like to get this done 
> sooner than later. There is some back-porting churn to worry about.

I think the movement I suggested would be sufficient:

  tools/testing/selftests/ =>  tools/selftests/

I.e. let's not clutter up the top level directory.

Thanks,

	Ingo
