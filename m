Return-Path: <linux-kselftest+bounces-3-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 171447E7ED3
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Nov 2023 18:47:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 422531C20A80
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Nov 2023 17:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F5138F96;
	Fri, 10 Nov 2023 17:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="jII52okw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79DC3A28F
	for <linux-kselftest@vger.kernel.org>; Fri, 10 Nov 2023 17:46:38 +0000 (UTC)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50CBB25081
	for <linux-kselftest@vger.kernel.org>; Fri, 10 Nov 2023 01:44:50 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9dd3f4a0f5aso304529266b.1
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Nov 2023 01:44:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1699609489; x=1700214289; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uNNVKkYwl/rOA9GX9/SH18oSRKfcJIfb4LTGsk7JdWQ=;
        b=jII52okwjfFGPIjLsibgww2+k7nV0tKlx4s8SQQwWNsZ4NJ9p09O+9mw489INMJe4m
         dvxZpSJQzHjDrIEtIRhS3ffkZfcKwSUaKO0CEwOT5dDlIxRV04Ri433CjVFbyFesiDTD
         jZwuyULGMnJg6D8BzQ/oZsJKTkVNaXt91gn8U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699609489; x=1700214289;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uNNVKkYwl/rOA9GX9/SH18oSRKfcJIfb4LTGsk7JdWQ=;
        b=QJ1ydG60r2/Hhbr34A1vJWknTuSdecFo8PwMxHXK47FetAF6g+lHmMAGsKggpw7SP0
         5y2tmZ9HRXwHKAygaiT2nekqKKItLZulPchcxvlS8/f+TI79StLWnERqZfmQTXtfXdKh
         YTWJpmS+Pvh8oy1bQ3KY5O0q8VxnPVaQMG7SyR3aLhmF3ThC4CkFE9BaFCkxy3UajmP/
         HM0G6EXb2ninrcEcHYZd2BAXmOeaPnj+T//j5YV4mNa/+2FYHCBVlyhEsp+Yknp5La9t
         3H0HE6V1u9rNByMPXnFJFRY3vpf4K5DSVc/pULuoQGZvilpaEyBXaTp88bS1b4bS5Yof
         IJ3w==
X-Gm-Message-State: AOJu0YzKLIJDYQ91GyO1iom5JfkouXTIhdnBsGwJy4rESAwDKQ1eT1SJ
	Bek4FCs8XBdajt7C8Ug09+3YVIey4ik0QRtefHML9g==
X-Google-Smtp-Source: AGHT+IHEDrhaS3SWGbZqZuG8sNPuZIIpHaBGL3VI6Da90hnwL9tRuf2Y3uqzB5/P6YHOqBSOAeAfq99hTGSbttzq3wg=
X-Received: by 2002:a17:906:8910:b0:9e4:121c:c292 with SMTP id
 fr16-20020a170906891000b009e4121cc292mr3096666ejc.77.1699609488646; Fri, 10
 Nov 2023 01:44:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1699564053.git.kjlx@templeofstupid.com>
In-Reply-To: <cover.1699564053.git.kjlx@templeofstupid.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 10 Nov 2023 10:44:37 +0100
Message-ID: <CAJfpegtOKLDy-j=oi8BsT+xjFnO+Mk7=8VxSDuyi-bxhRSGMKQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] Fuse submount_lookup needs to be initialized
To: Krister Johansen <kjlx@templeofstupid.com>
Cc: linux-fsdevel@vger.kernel.org, Miklos Szeredi <mszeredi@redhat.com>, 
	linux-kernel@vger.kernel.org, German Maglione <gmaglione@redhat.com>, 
	Greg Kurz <groug@kaod.org>, Max Reitz <mreitz@redhat.com>, 
	Bernd Schubert <bernd.schubert@fastmail.fm>, 
	"Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>, 
	Naresh Kamboju <naresh.kamboju@linaro.org>, Dan Carpenter <dan.carpenter@linaro.org>, 
	"Kurmi, Suresh Kumar" <suresh.kumar.kurmi@intel.com>, "Saarinen, Jani" <jani.saarinen@intel.com>, 
	lkft-triage@lists.linaro.org, linux-kselftest@vger.kernel.org, 
	regressions@lists.linux.dev, intel-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 9 Nov 2023 at 23:37, Krister Johansen <kjlx@templeofstupid.com> wrote:

> Either should do, but I wasn't sure which approach was preferable.

An incremental is better in this situation.   Applied and pushed.

> Thanks, and my apologies for the inconvenience.

Really no need to apologize, this happens and the best possible
outcome is that it get fixed before being released.

Thanks,
Miklos

