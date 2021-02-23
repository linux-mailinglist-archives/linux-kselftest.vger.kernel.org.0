Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAFA132309D
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Feb 2021 19:24:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233898AbhBWSW7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 23 Feb 2021 13:22:59 -0500
Received: from mout.gmx.net ([212.227.17.21]:50059 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233955AbhBWSWy (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 23 Feb 2021 13:22:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1614104458;
        bh=LNGMe6Cvd1XCSfu9VVHlx9YQUG5vihvHCmqx0hhKPV0=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=b8eXfWIkdfI9dqA57yi3nGbosdYSBUNJDMhOcRw2GHPH+dmOh5uC1J/Hp31YZAjcV
         +zRAAeXdyMj0KmiFei6nCtQHfCM5Kjz0ZWIZHdOnf66PLP8B3Ebx3ej/ZKOlI4U0zF
         l4jmOUDGQowruQpseoLGbz41Ek7Tdms7Lld9j6/c=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ubuntu ([83.52.229.153]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N4Qwg-1lwA162sXW-011Tar; Tue, 23
 Feb 2021 19:20:58 +0100
Date:   Tue, 23 Feb 2021 19:20:54 +0100
From:   John Wood <john.wood@gmx.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        James Morris <jmorris@namei.org>, Shuah Khan <shuah@kernel.org>
Cc:     John Wood <john.wood@gmx.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 3/8] securtiy/brute: Detect a brute force attack
Message-ID: <20210223182054.GB3068@ubuntu>
References: <20210221154919.68050-1-john.wood@gmx.com>
 <20210221154919.68050-4-john.wood@gmx.com>
 <f4fd9e44-539e-279e-a3a6-8af39f863f73@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f4fd9e44-539e-279e-a3a6-8af39f863f73@infradead.org>
X-Provags-ID: V03:K1:HHPCxdrBHvji0o9LTCCMJdtyWfbj8bwS0V/XvyVAe4PUGRQrPFi
 klx54ZU4/Kz8iqglnyYer/wrmY6B2QFNcz3TwL3MDj8RvYaldC6XSITmO5dUCfIrdrMohTo
 q8QYCfWxasXAEaxuB7y2CmOvutmjLtvoutB4OsnMqkBvznmJ3nUxH9O1WTh0r/Xfbci76VB
 IJGnOEZOmOX102WUkuolA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:z5dm1mICMC0=:e0YCvR3+cDEyUvDDJkEqGc
 XPksfhcj1y8ui+NpkMjrwFGhmx4HdXtYLDypP8CJLb1ZOc4Bdnu6udfgRmBjX64c8O8ad/osG
 fEgpg8RFAf4woOA2xtMffDyeBMoURSSLARclBQMmkhFxa2Kg1pZje3uGnJkVW1IBKVPiM8wgd
 JhWWDvUvfA3ThI6EetU8e2gc3WYNs4+puN6544+RJsESWnzDxzPupqdEOEsU9BxFqvJCoA69+
 zCJPNmW8lD0u+aPARsZ1rnZM7vQDztTy4QUDpNZu0eHMPIgc5WTaYyRwattiaR7gJzhQpZCAe
 G0y1jupIrMlWOgbiVuHYnO3xObLnNAglVUYLFOk/CwEACVMpzOFB+NNe4Xww51CNRhDZfONfz
 TAvv30M/p1UEzYIsFi0Rp2YFblKrzmEQ14DtOLuCF86NfnJFCVWEG3Imb3x5JkegnqEbTmG6R
 cmmqLiDcd5s8sxALXU1H2gvSRMZKUGFYyRxSSGuLBs+h7gkx24wpx2uRWludOfmJ0E/DMrdx1
 jlaeB1Pjqv5pnlFVwQ8gVCu3lJ1rC24wxmGPbnm39azsjtTxAM2UsKXbBKrKMhD3PaBC3WUlt
 luE6+2hCXoZcrM07zqyJIxjgj4klpwhETczxys3cXhXdMXRFAOlnc6TKZfciIJJ/msAnNxldB
 B15BapT7mte9IT2E49dGmGA/7N5KJCFTaiIDB8S0PcwALpnOyvU+MuowahyPfCC+Sl+IG6syg
 nibnJkQRZ5xZQS0J+hIk7MXZ1iK4am/qmviGBwxctJJl1IkJrL9epVg1OHf2yi0o+eJl20iK/
 KKNmrUQHOOBSW+gCv88i5h1WeSS2U8TVhkz2kv1UmB0iWct6p8DA8KTfdPV/tnWwphLRWW6Uu
 +GW/Zbu3UM/Ra/8q7TFQ==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

On Sun, Feb 21, 2021 at 06:47:16PM -0800, Randy Dunlap wrote:
> Hi--
>
> scripts/kernel-doc does not like these items to be marked
> as being in kernel-doc notation. scripts/kernel-doc does not
> recognize them as one of: struct, union, enum, typedef, so it
> defaults to trying to interpret these as functions, and then
> says:
>
> (I copied these blocks to my test megatest.c source file.)
>
>
> ../src/megatest.c:1214: warning: cannot understand function prototype: '=
const u64 BRUTE_EMA_WEIGHT_NUMERATOR =3D 7; '
> ../src/megatest.c:1219: warning: cannot understand function prototype: '=
const u64 BRUTE_EMA_WEIGHT_DENOMINATOR =3D 10; '
> ../src/megatest.c:1228: warning: cannot understand function prototype: '=
const unsigned char BRUTE_MAX_FAULTS =3D 200; '
> ../src/megatest.c:1239: warning: cannot understand function prototype: '=
const unsigned char BRUTE_MIN_FAULTS =3D 5; '
> ../src/megatest.c:1249: warning: cannot understand function prototype: '=
const u64 BRUTE_CRASH_PERIOD_THRESHOLD =3D 30000; '
>
>
> On 2/21/21 7:49 AM, John Wood wrote:
> >
> > +/**
> > + * brute_stats_ptr_lock - Lock to protect the brute_stats structure p=
ointer.
> > + */
> > +static DEFINE_RWLOCK(brute_stats_ptr_lock);
>
> > +/**
> > + * BRUTE_EMA_WEIGHT_NUMERATOR - Weight's numerator of EMA.
> > + */
> > +static const u64 BRUTE_EMA_WEIGHT_NUMERATOR =3D 7;
>
> > +/**
> > + * BRUTE_EMA_WEIGHT_DENOMINATOR - Weight's denominator of EMA.
> > + */
> > +static const u64 BRUTE_EMA_WEIGHT_DENOMINATOR =3D 10;
>
> > +/**
> > + * BRUTE_MAX_FAULTS - Maximum number of faults.
> > + *
> > + * If a brute force attack is running slowly for a long time, the app=
lication
> > + * crash period's EMA is not suitable for the detection. This type of=
 attack
> > + * must be detected using a maximum number of faults.
> > + */
> > +static const unsigned char BRUTE_MAX_FAULTS =3D 200;
>
> > +/**
> > + * BRUTE_MIN_FAULTS - Minimum number of faults.
> > + *
> > + * The application crash period's EMA cannot be used until a minimum =
number of
> > + * data has been applied to it. This constraint allows getting a tren=
d when this
> > + * moving average is used. Moreover, it avoids the scenario where an =
application
> > + * fails quickly from execve system call due to reasons unrelated to =
a real
> > + * attack.
> > + */
> > +static const unsigned char BRUTE_MIN_FAULTS =3D 5;
>
> > +/**
> > + * BRUTE_CRASH_PERIOD_THRESHOLD - Application crash period threshold.
> > + *
> > + * The units are expressed in milliseconds.
> > + *
> > + * A fast brute force attack is detected when the application crash p=
eriod falls
> > + * below this threshold.
> > + */
> > +static const u64 BRUTE_CRASH_PERIOD_THRESHOLD =3D 30000;
>
> Basically we don't support scalars in kernel-doc notation...

So, to keep it commented it would be better to use a normal comment block?

/*
 * Documentation here
 */

What do you think?

Thanks,
John Wood

> --
> ~Randy
>
