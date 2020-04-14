Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9BDE1A74F3
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Apr 2020 09:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406753AbgDNHio (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Apr 2020 03:38:44 -0400
Received: from mga14.intel.com ([192.55.52.115]:17094 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406749AbgDNHil (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Apr 2020 03:38:41 -0400
IronPort-SDR: AhOc6Pk2gJj8rAGBrfVsURJ7Iv+qYdSfVVNdQ6GZe2VOfqZ6aNHw9V9mI4MaSDt61opLn/v2ZM
 LcVwHQX05CRQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2020 00:38:40 -0700
IronPort-SDR: u+NegoB65VxBLzzbNz52A3oNkKqeXE5OURkh1WIUBU5g3XZQN7g+CDWy+Kk8vwu0Oqk7NcgKYc
 JSlvyFo/rVVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,381,1580803200"; 
   d="scan'208";a="399872713"
Received: from elenamax-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.42.208])
  by orsmga004.jf.intel.com with ESMTP; 14 Apr 2020 00:38:15 -0700
Date:   Tue, 14 Apr 2020 10:38:06 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Ezra Buehler <ezra@easyb.ch>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] selftests/tpm2: Change exception handling to be Python 3
 compatible
Message-ID: <20200414073806.GE8403@linux.intel.com>
References: <20200412143656.72955-1-jarkko.sakkinen@linux.intel.com>
 <1FE03B4F-C42C-4B5F-A4B5-8169705911FA@easyb.ch>
 <20200412170719.GA324408@linux.intel.com>
 <531D50E8-E8FC-402E-9226-6000E8B6E960@easyb.ch>
 <20200413180440.GA10917@linux.intel.com>
 <D670A3F7-6FE2-4A07-8251-680C2ED27764@easyb.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D670A3F7-6FE2-4A07-8251-680C2ED27764@easyb.ch>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Apr 14, 2020 at 07:45:33AM +0200, Ezra Buehler wrote:
> Hi Jarkko,
> 
> On 13 Apr 2020, at 20:04, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com> wrote:
> > 
> > On Mon, Apr 13, 2020 at 07:02:20AM +0200, Ezra Buehler wrote:
> >> Hi Jarkko,
> >> 
> >> On 12 Apr 2020, at 19:07, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com> wrote:
> >>> 
> >>> On Sun, Apr 12, 2020 at 05:02:27PM +0200, Ezra Buehler wrote:
> >>>> Hi Jarkkon,
> >>>> 
> >>>>> On 12 Apr 2020, at 16:36, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com> wrote:
> >>>>> +        except ProtocolError(e):
> >>>> 
> >>>> Should this not be
> >>>> 
> >>>>       except ProtocolError as e:
> >>> 
> >>> Unless there is a functional difference, does it matter?
> >>> 
> >>> /Jarkko
> >> 
> >> Well, your patch confuses me a lot. It looks to me like you are passing
> >> the undefined `e` variable to the constructor.
> >> 
> >> When I run flake8 on it I get following error (among others):
> >> 
> >>    F821 undefined name 'e'
> > 
> > I don't know what flake8 is.
> 
> https://flake8.pycqa.org/en/latest/
> 
> >> What I suggested is the standard syntax:
> >> https://docs.python.org/3/tutorial/errors.html
> > 
> > It passed the Python 3 interpreter.
> 
> That is because it is technically valid syntax.
> 
> >> Did you test this? You should get an error as soon as an exception
> >> occurs.
> > 
> > Yes. Interpreter did not complain. I did not know that the language
> > is broken that way that you have to exercise the code path to get
> > a syntax error.
> 
> That is due to the dynamic nature of Python. You won’t get a syntax
> error. You will get an exception:
> 
>     NameError: name 'e' is not defined
> 
> Python has to assume that `e` might be defined at runtime. However,
> style checkers will complain.

OK, I'm aware about the dynamic nature but in this case it is somewhat
counter intuitive since it is part of the exception clause. You'd except
the Python interpreter to complain.

So, is Flake8 like the standard to be used?

/Jarkko
