Return-Path: <linux-kselftest+bounces-27257-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D15FA406E8
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Feb 2025 10:30:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69E5842587D
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Feb 2025 09:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C46F2066F8;
	Sat, 22 Feb 2025 09:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WGXNIDYW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D613E1D7E42;
	Sat, 22 Feb 2025 09:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740216651; cv=none; b=ji9uw2lNvUEZ+1odszT/gdzxL2Ga8/93AnBZ0irdHSup0edxCAAOwj7GDx3r6uVvH3mBBvJ1U6OeO+bPnEQP6Iv1f4cmQrCyfrREv2mHETkc8rbjiiKHsJ30vEbze+aXem82KHw/rQYYbHMNlUz7F/TVsgHxASnrt7gjgzQ6TEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740216651; c=relaxed/simple;
	bh=hXAr6oIEi+/PIbCR5b0ihPtXixUgLNht0f3STJblDVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZnPWFx29SiXXsYf/qprXLuB0Qq3UduzdndG1Zm2tH0avuLZYPS5NEw2mzzJE8uKtVnRvHsLG1Gw9jWBJINkjB2lDbp+szCV1dkhQl6U9k4kegXvb7Wn3o8Dc4dRulEtyuz80qICUHOAd4WX4CgiusJpw14HyelJTyCmaeF6ocEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WGXNIDYW; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-220f4dd756eso58735985ad.3;
        Sat, 22 Feb 2025 01:30:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740216649; x=1740821449; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hXAr6oIEi+/PIbCR5b0ihPtXixUgLNht0f3STJblDVk=;
        b=WGXNIDYWSpRntp9kA1YnO+pZu25Mdpx8/yKZwg1/HPakvl0RIz/4VAJQZmpc+nh+cC
         SHMpof9ZIFbk0QbMqCwZ+qLbACwwvERfeCtemmeNM5UjnldtzrIsrANVZ0EmpKssV/Lk
         0VRqbb6cIwaUJsW3TyDU+eJR9Ym+tJruJicb00oi9Muq3OoJYBSEUDlaJ/NtBjDjjwlr
         KFQ9kOIGUxAfYCU3dx+szaYKfe7tB2NVdnITeUaY5v2oW7ue0dOhhTvxwlbzf0yM0C+L
         rtR96DFXDYLtqpUcMrhlJ5D+kICGgI6LiknkCUXEOs6yrdH/vEGKAu885xqOrzVAlV1k
         7kSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740216649; x=1740821449;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hXAr6oIEi+/PIbCR5b0ihPtXixUgLNht0f3STJblDVk=;
        b=Xcx73cclWYbAN9xpMXJwAc9/8PHuykPTU7U1UrxF2/3zIEOmZ4cACk9cE/xZqOihxO
         UQZy02w+o+0zxod/wPtczL0QOfQjqmevzmt1kpqaCl0XVx+pOH9cV2KQobt9jDwz8vY6
         +IKypOYNddMwHxcnSTUevwy4U7dMNQsdfHE+rSXjVmwnT8OzbCITYCZ3M9yHh4r1Hh4e
         bKv9w/3Xk16q5DPbmwaMfR/raM08s1oXenPj8bwCAWF7e5ksjWKY9vLoGhwFB6G219MG
         sowdhc3wZBzfeho94r2vwNTAhbahk45pwEHP1XeKGmffddef3H2chlwIFladHgTGYmJy
         gKqw==
X-Forwarded-Encrypted: i=1; AJvYcCX6/FMn9AVCVZyAbzpiOpjGaOngVmkejlII3DlyCVQKOaW2kQYhtIv/rs3pWrRWSwKPl3rzBgATuNcxuuY=@vger.kernel.org, AJvYcCXF/+pdgE9CyNlwED2X1HYPO3Lhs3UAgkVyVeu+lO1Qb4aXMtDjaOm8KseUmE2177V9nej/6PTXv9IOddr/QTpa@vger.kernel.org
X-Gm-Message-State: AOJu0YxZFgducslNIR1VfL5ryn8FF+5CIpzjAIRy0N+OrhJMHFp4RsK3
	8mkYIBSF5m8domjBmNXRMXfclmtzbevZqCHtrcJByyJybzRYc5m0
X-Gm-Gg: ASbGncvv+dDCs60BvB25RPvwf/zGvvBCI2qf8Fa8AW2Ae2+15LCvfPqGTno26154rHp
	eeNxXbsdG4FNP3rgKdD88IQb7WWaWIUgjOHBsl72yTaIsHoxHPENjlNjK6QVScBgmVyQivv0iGG
	URsboUxGfoNiOkrlZnea/odN+wzW5XUTBEsjdznJkQh1p+WRyVrrVcvb5oPZm83QgiSr/Xhttqv
	/rKaCQzkSC0oDf1IsqF16opND/yXdKIkMhZ7JTH/etiwbyaUNBCJhuCorVpzwW57JA1TJOFg8tm
	aMj7RbpJJzFTYkYgM89TRzZnFHorRY8ooXaYZN1UBraxo1OT
X-Google-Smtp-Source: AGHT+IHdUVu20s80g9zpUNttiyeCSlx4ll29y5Rr7CdK3ZqQIPl/f/zJ6Puh0U3kaJqAewMl+0S1jQ==
X-Received: by 2002:a17:903:178b:b0:21f:140e:2929 with SMTP id d9443c01a7336-2219ff4e2f6mr101409025ad.15.1740216649065;
        Sat, 22 Feb 2025 01:30:49 -0800 (PST)
Received: from ritvikos.localdomain ([49.36.192.173])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fcb8351600sm4025373a91.0.2025.02.22.01.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2025 01:30:48 -0800 (PST)
Received: by ritvikos.localdomain (Postfix, from userid 1000)
	id 55655ED9143; Sat, 22 Feb 2025 15:00:44 +0530 (IST)
Date: Sat, 22 Feb 2025 15:00:44 +0530
From: Ritvik Gupta <ritvikfoss@gmail.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: shuah@kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] selftests/mount: Explicitly define buffer size
Message-ID: <Z7mZRO0eCwRU2JhG@ritvikos>
References: <20250222081711.48208-1-ritvikfoss@gmail.com>
 <2025022257-easter-shower-61df@gregkh>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025022257-easter-shower-61df@gregkh>

Got it :)
Thanks for reviewing!
Regards Ritvik

