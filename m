Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8457498F8
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jun 2019 08:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbfFRGmY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Jun 2019 02:42:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:50070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726505AbfFRGmY (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Jun 2019 02:42:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7ADB12147A;
        Tue, 18 Jun 2019 06:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560838992;
        bh=pbkoxknInWcDnCO27Z3tX5DgOlNynw052iJ9NOpp13A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WJSp+v4GgBVCRWykiqWwQwsQPfAmNCMSb9dfMWOqt4A8zEGZ0FW1Jfbl6/D2zHks5
         E2Wsjsg1+O2zNamZjmz92BozbIXqL2GNflS33UmFEHOZnfkSjMGzxGw4IF/jSvKgb3
         Wj3b85epx/JkReM9DzK0XyHNzQzLojYQz/k6uAsk=
Date:   Tue, 18 Jun 2019 08:23:09 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Christian Clauss <cclauss@me.com>
Cc:     linux-kselftest@vger.kernel.org
Subject: Re: Fixing Python 3 syntax errors in tpm2_tests.py
Message-ID: <20190618062309.GB8506@kroah.com>
References: <B021B4EF-903E-4EA2-9B2B-0B0301D28DE7@me.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <B021B4EF-903E-4EA2-9B2B-0B0301D28DE7@me.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jun 17, 2019 at 11:28:34PM +0200, Christian Clauss wrote:
> Hello,
> 
>     As my very first contribution to the Linux Kernel, I would like to fix six Python 3 syntax errors in the file ./tools/testing/selftests/tpm2/tpm2_tests.py
> 
>     All six of these errors are of the same form: except ProtocolError, e:  To fix the syntax errors, I propose to change the comma (,) to “as” like:  except ProtocolError as e:
> 
>     These changes are important because the current form is compatible with Python 2 but is a syntax error in Python 3.  The proposed form is compatible with both Python 2 and Python3.  This conversion is required because Python 2 will reach its end of life in less than 200 days.
> 
>     The kernel contains at least five other files where I am able to detect Python 3 syntax errors but after studying in detail the process of making kernel modification, I believe that it is best to start with tpm2_tests.py because the changes are straightforward and uncontroversial — all issues are of the same form, and I can detect no other issues (such as undefined names) to fix in that file.
> 
>    If I succeed in getting the modifications to tpm2_tests.py through the review process then I can try the remaining files in turn.
> 
>    I would be interested to know if this is a worthwhile effort.  Is there already another initiative to resolve these issue before yearend?

Just send patches, and we will be glad to review them as-is.  No need to
ask permission ahead of time, we do not "reserve" tasks for people.

thanks,

greg k-h
