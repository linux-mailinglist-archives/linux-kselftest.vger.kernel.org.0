Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2F731A7933
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Apr 2020 13:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390838AbgDNLOS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Apr 2020 07:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390836AbgDNLOP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Apr 2020 07:14:15 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8DBAC061A0F
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Apr 2020 04:14:14 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id e26so12541851wmk.5
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Apr 2020 04:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=easyb-ch.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=2hf2r+2wVOWBvmSoLn7/fDnDty1h5K4Nf4IQt6b/VXs=;
        b=oZuCdEKrLiXXACXu02t5Ord1KePOALbWLPWSCdt0MaGN6o60hFWt7+Anj+VqW6mz3c
         5RAqS9SQUBW6sd+kaDpyTWwJkBHxsG2+xT2IOhXMKe28847HtBZYcdqvyGaCTbJssfia
         vl9WPxEtjLO7iuAJ3CvgFOwOY/661H8LqVY4pgw3rQDLwmR2yHKihrr8fl6BuTYtQhx/
         3lMKPdBP98AIeeHTF7XhtKIk0WEjSC9yoShfOsW8mexfyOPRwusOTu1CC0nj1IXQgc3G
         lFG2LH7CVDCULB7DhsrZhrx6r92JcqEhS7dVGtcABZOwRHYuSsnngd0/PVs51NrmMJMI
         xipQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=2hf2r+2wVOWBvmSoLn7/fDnDty1h5K4Nf4IQt6b/VXs=;
        b=TgPc4rDT2Xerr5uUM/dS+E6ATKEplF2jpNAqZHc/RKcjFmdUckx1zsMDtbJcZMURVQ
         LyiXlndoOaIk6aVL4Xawy5dnTAzrchs4PyGQjNq1doK8xuucFk5gnf+JGonBfVGYR4mD
         XmeiNrvjRr35loZUrUFp5iuqN7p0YOnYh8ppnHuzeDVUWaktfO0KId95kojsEAnMlZBz
         8N9Zsae5uVwDCgK+A70xQ9fvBtBICvExol/BkvQFm7G5Q8TVMOJNFlGtNCNjgEkQK+97
         sAbnEIfuy2/gZqlJ1xgv7iUZ4QZPFzVkrZ5tZJyL07Ssbcv+6/QT+K2QgdGCKDC8t1Ep
         eq8w==
X-Gm-Message-State: AGi0Pubm1h3bIagN5XOUrGFOSNu93XRKE0oP5bOBWpobFhnmU8tqztAB
        KaDNJ15ZBu+cKQ70FjbXls7HrA==
X-Google-Smtp-Source: APiQypINQ5Int4XZmMvn1pNdc97YjR9Zh6ogA4Ast3SBJ5dyvLsyW2d/9AW+u29N+In+zEZDIKOntA==
X-Received: by 2002:a1c:1b88:: with SMTP id b130mr22771164wmb.75.1586862853356;
        Tue, 14 Apr 2020 04:14:13 -0700 (PDT)
Received: from [10.0.0.131] (adsl-84-227-160-19.adslplus.ch. [84.227.160.19])
        by smtp.gmail.com with ESMTPSA id p10sm18165006wrm.6.2020.04.14.04.14.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Apr 2020 04:14:12 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.5\))
Subject: Re: [PATCH] selftests/tpm2: Change exception handling to be Python 3
 compatible
From:   Ezra Buehler <ezra@easyb.ch>
In-Reply-To: <20200414073806.GE8403@linux.intel.com>
Date:   Tue, 14 Apr 2020 13:14:11 +0200
Cc:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <3DDD1D36-9FCC-480A-978F-3BD08283DA03@easyb.ch>
References: <20200412143656.72955-1-jarkko.sakkinen@linux.intel.com>
 <1FE03B4F-C42C-4B5F-A4B5-8169705911FA@easyb.ch>
 <20200412170719.GA324408@linux.intel.com>
 <531D50E8-E8FC-402E-9226-6000E8B6E960@easyb.ch>
 <20200413180440.GA10917@linux.intel.com>
 <D670A3F7-6FE2-4A07-8251-680C2ED27764@easyb.ch>
 <20200414073806.GE8403@linux.intel.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
X-Mailer: Apple Mail (2.3445.9.5)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 14 Apr 2020, at 09:38, Jarkko Sakkinen =
<jarkko.sakkinen@linux.intel.com> wrote:
> OK, I'm aware about the dynamic nature but in this case it is somewhat
> counter intuitive since it is part of the exception clause. You'd =
except
> the Python interpreter to complain.

I agree.

> So, is Flake8 like the standard to be used?

Pretty much, yes. There is also Pylint though. Among other things, they
both check for PEP 8 (official) coding style compliance.

Cheers,
Ezra.

> On 14 Apr 2020, at 09:38, Jarkko Sakkinen =
<jarkko.sakkinen@linux.intel.com> wrote:
>=20
> On Tue, Apr 14, 2020 at 07:45:33AM +0200, Ezra Buehler wrote:
>> Hi Jarkko,
>>=20
>> On 13 Apr 2020, at 20:04, Jarkko Sakkinen =
<jarkko.sakkinen@linux.intel.com> wrote:
>>>=20
>>> On Mon, Apr 13, 2020 at 07:02:20AM +0200, Ezra Buehler wrote:
>>>> Hi Jarkko,
>>>>=20
>>>> On 12 Apr 2020, at 19:07, Jarkko Sakkinen =
<jarkko.sakkinen@linux.intel.com> wrote:
>>>>>=20
>>>>> On Sun, Apr 12, 2020 at 05:02:27PM +0200, Ezra Buehler wrote:
>>>>>> Hi Jarkkon,
>>>>>>=20
>>>>>>> On 12 Apr 2020, at 16:36, Jarkko Sakkinen =
<jarkko.sakkinen@linux.intel.com> wrote:
>>>>>>> +        except ProtocolError(e):
>>>>>>=20
>>>>>> Should this not be
>>>>>>=20
>>>>>>      except ProtocolError as e:
>>>>>=20
>>>>> Unless there is a functional difference, does it matter?
>>>>>=20
>>>>> /Jarkko
>>>>=20
>>>> Well, your patch confuses me a lot. It looks to me like you are =
passing
>>>> the undefined `e` variable to the constructor.
>>>>=20
>>>> When I run flake8 on it I get following error (among others):
>>>>=20
>>>>   F821 undefined name 'e'
>>>=20
>>> I don't know what flake8 is.
>>=20
>> https://flake8.pycqa.org/en/latest/
>>=20
>>>> What I suggested is the standard syntax:
>>>> https://docs.python.org/3/tutorial/errors.html
>>>=20
>>> It passed the Python 3 interpreter.
>>=20
>> That is because it is technically valid syntax.
>>=20
>>>> Did you test this? You should get an error as soon as an exception
>>>> occurs.
>>>=20
>>> Yes. Interpreter did not complain. I did not know that the language
>>> is broken that way that you have to exercise the code path to get
>>> a syntax error.
>>=20
>> That is due to the dynamic nature of Python. You won=E2=80=99t get a =
syntax
>> error. You will get an exception:
>>=20
>>    NameError: name 'e' is not defined
>>=20
>> Python has to assume that `e` might be defined at runtime. However,
>> style checkers will complain.
>=20
> OK, I'm aware about the dynamic nature but in this case it is somewhat
> counter intuitive since it is part of the exception clause. You'd =
except
> the Python interpreter to complain.
>=20
> So, is Flake8 like the standard to be used?
>=20
> /Jarkko

