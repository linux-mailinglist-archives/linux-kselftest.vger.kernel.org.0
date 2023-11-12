Return-Path: <linux-kselftest+bounces-33-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B5A57E910C
	for <lists+linux-kselftest@lfdr.de>; Sun, 12 Nov 2023 14:50:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92DF0B20425
	for <lists+linux-kselftest@lfdr.de>; Sun, 12 Nov 2023 13:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55CAA525A;
	Sun, 12 Nov 2023 13:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k/3hFxBb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F521170B;
	Sun, 12 Nov 2023 13:50:01 +0000 (UTC)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE3E2688;
	Sun, 12 Nov 2023 05:50:00 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id 46e09a7af769-6ce31c4a653so2174131a34.3;
        Sun, 12 Nov 2023 05:50:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699797000; x=1700401800; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JB2I+B+rYFLkS4fe+E3Z3AcXhS19RY8fRv5WzyVTB9U=;
        b=k/3hFxBblLi/ExgW2C2/RCt42RHKHZncdgAPvH2tm/IFmiB3L6nZtu8x5sPI5G0kyk
         Yys1wZ6EBmSXp4JWz7B0LKqoIPgKh2Z8G9/X5q5/fx5Xp4HwgtTx0HX06peAqNsL6uUA
         jFWDudx4FHu46GcJR3MD2yT+H+iY2OAT5WPkRFBSVtl8tUYK2alczriZCSz9RnG6ofIN
         hRbf/9TK+HCEezNH32SpWCAKOHoJbqqWyG+aDx8b/ZtXhfGKMvvmcWydJDcHsDO9dHiE
         ugpDn4sSDmUCLpnTgWtUbLr7SQkbgilSg4dv+x4hYtC+eyH6G3VM02bnpOOhiDmVAT8d
         LacA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699797000; x=1700401800;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JB2I+B+rYFLkS4fe+E3Z3AcXhS19RY8fRv5WzyVTB9U=;
        b=eQa781wm7lEqkU3QhGMA4tTM5VUGTC1komDqcdFva6r38Ar9Lkq5OrZ/sFl3UoNG3H
         a7yJLKdmkYyuaLZBo5wBBG41nyldjvicW/SIfm66XTTBynxKFQW54JGGKM3GDsjWhmn/
         7/k/DiapZyq64LxXozKxNh6EMz3DT1iShaH0MK+ps/8Y9XggVBYwWzd6WQSohS00mWpo
         NviInI5v2BXZWakWemWBXAnPD6Hjadf9eMnz+mBeb2OYjOcEp+cZ/eCWtgf3DKOW/9UO
         FdExIWhUzDEL3jmgh9XQ4QPnruKGkKxKjBmwuY0xRR1alHMrE5sD4u3oiojB2tyA+kxF
         JNdw==
X-Gm-Message-State: AOJu0Yz91NTZI2VlvQoGrapQAa+K3zulkBrdXCWeLAsYeWWJ/H6T6WnJ
	Y1k0k3ntL5UGbXIihN+KmCzN0ifPx5g=
X-Google-Smtp-Source: AGHT+IE47XF45kXA0ihvXDA4astRGQHI6+R4GExIHLFZ33T4m3r1jhFXaC1lvxd5ruxEiOux5/TdhQ==
X-Received: by 2002:a9d:62d4:0:b0:6c1:7927:6550 with SMTP id z20-20020a9d62d4000000b006c179276550mr5393270otk.2.1699797000239;
        Sun, 12 Nov 2023 05:50:00 -0800 (PST)
Received: from atom0118 ([2405:201:6815:d829:c9ab:5d66:b313:f881])
        by smtp.gmail.com with ESMTPSA id j191-20020a6380c8000000b00578b8fab907sm2693829pgd.73.2023.11.12.05.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Nov 2023 05:49:59 -0800 (PST)
Date: Sun, 12 Nov 2023 19:19:53 +0530
From: Atul Kumar Pant <atulpant.linux@gmail.com>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: a.zummo@towertech.it, alexandre.belloni@bootlin.com, shuah@kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-rtc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] selftests: rtc: Fixes rtctest error handling.
Message-ID: <20231112134953.GA11910@atom0118>
References: <20230817091401.72674-1-atulpant.linux@gmail.com>
 <20230923173652.GC159038@atom0118>
 <20231007154318.GC20160@atom0118>
 <22df3ecb-488c-4d58-8efe-4638fa3d614b@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22df3ecb-488c-4d58-8efe-4638fa3d614b@linuxfoundation.org>

On Tue, Nov 07, 2023 at 02:27:35PM -0700, Shuah Khan wrote:
> On 10/7/23 09:43, Atul Kumar Pant wrote:
> > On Sat, Sep 23, 2023 at 11:06:58PM +0530, Atul Kumar Pant wrote:
> > > On Thu, Aug 17, 2023 at 02:44:01PM +0530, Atul Kumar Pant wrote:
> > > > Adds a check to verify if the rtc device file is valid or not
> > > > and prints a useful error message if the file is not accessible.
> > > > 
> > > > Signed-off-by: Atul Kumar Pant <atulpant.linux@gmail.com>
> > > > ---
> 
> 
> Sorry for the delay. I will pick this up for the next rc.
> 
> thanks,
> -- Shuah

	Thanks Shuah

