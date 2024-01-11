Return-Path: <linux-kselftest+bounces-2855-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A4782AF9E
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jan 2024 14:24:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C72BDB2147E
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jan 2024 13:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F242915E89;
	Thu, 11 Jan 2024 13:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="g4FcSt7e"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8DA15EA1
	for <linux-kselftest@vger.kernel.org>; Thu, 11 Jan 2024 13:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a2821884a09so446658766b.2
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Jan 2024 05:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1704979426; x=1705584226; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=B3N6N//FH5YjUxtiswqbQpXXpmb0SuS1hr7tKADDnR4=;
        b=g4FcSt7ezoILoYKslIpzUx8N6rsF7zqnrTUxECheyEtPg0ZpCq0yenNC++Eai6BKJ9
         3QrV1IvQSjzEBtbVzeKmW4NxWZ2DSMD5OdUytFIu0SR2gt4Jwjw4W8Z5YA4CciyBRJA3
         Clz2rwuSMGcJNUUSG4NfZtCH+di+I1mlXvvcilNZw6MS9utxTszJ2hlHRqeyV31RDYDt
         Udg0FO7QjScJ7d141ZiY/TLC44X7nqm6XocssNZBGgZ+SxRHJpLeh0RjrBpCMc1ZPUuf
         2ISjZ/emNy/iWwOVHVjOqkbG4pakPlbhu8Ozd43LgO+rKkO/axv3BH/dEWc9CWrOUeJU
         nPrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704979426; x=1705584226;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B3N6N//FH5YjUxtiswqbQpXXpmb0SuS1hr7tKADDnR4=;
        b=MIV6JVK+q5gbRUhb2fwWdtwQxiE6T/Q0JR4v+AnyuH3cWc/ebv0k4XPHpQVcTRZNmo
         EBaFoEXTxkTkKKwRW21Ii8dFdbDbTlfCuz4iDbqFdTj44GPpoRNxAVucgYQI4gXLY6rF
         La8tAbP7q3gez85+n5iPmTqWwwFktDW8q7MuWvwOC5kjvxWyDQCWEBplmbJBBod5bXGB
         ev7GA5hsj2k75BqS47YyOC+udQJPUF0WKKGSW733GIcMub5Eem57K1RjxZaANoOHZm6j
         6UTnrhfqClrREnCshmFOL8v5QqSvc3Au8pMrAPeEPf65AiaEiBSlx/60AhjF6LkHid/e
         KDRA==
X-Gm-Message-State: AOJu0Yx7C1snTpRrZd+u1iwEkZaMJRTGjir6ATCCg3Z5WD9E4S2wQ4fa
	Go+COt9iX3vJuIWf7w0ULmvrC0KKkFfDoQ==
X-Google-Smtp-Source: AGHT+IFXOvSVDbjxPZh7mjSDt/GGARAM9PnQRsmytJ2pne0zYkgIye0VKsMq58SY5H1gxVIALugl9Q==
X-Received: by 2002:a17:906:b2c7:b0:a2c:3596:b0c1 with SMTP id cf7-20020a170906b2c700b00a2c3596b0c1mr683185ejb.75.1704979426218;
        Thu, 11 Jan 2024 05:23:46 -0800 (PST)
Received: from alley ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id d14-20020a170906c20e00b00a298e2f6b3csm565484ejz.213.2024.01.11.05.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 05:23:45 -0800 (PST)
Date: Thu, 11 Jan 2024 14:23:43 +0100
From: Petr Mladek <pmladek@suse.com>
To: Marcos Paulo de Souza <mpdesouza@suse.com>
Cc: Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
	live-patching@vger.kernel.org
Subject: Re: [PATCH v5 2/3] livepatch: Move tests from lib/livepatch to
 selftests/livepatch
Message-ID: <ZZ_r3wtMLi10Li26@alley>
References: <20240109-send-lp-kselftests-v5-0-364d59a69f12@suse.com>
 <20240109-send-lp-kselftests-v5-2-364d59a69f12@suse.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240109-send-lp-kselftests-v5-2-364d59a69f12@suse.com>

On Tue 2024-01-09 21:24:55, Marcos Paulo de Souza wrote:
> The modules are being moved from lib/livepatch to
> tools/testing/selftests/livepatch/test_modules.
> 
> This code moving will allow writing more complex tests, like for example an
> userspace C code that will call a livepatched kernel function.
> 
> 
> Reviewed-by: Joe Lawrence <joe.lawrence@redhat.com>
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>

Looks good and works for me.

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

