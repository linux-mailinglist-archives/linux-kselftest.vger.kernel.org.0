Return-Path: <linux-kselftest+bounces-37969-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA38EB11654
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Jul 2025 04:20:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF7AF54864C
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Jul 2025 02:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD5A72264A9;
	Fri, 25 Jul 2025 02:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OzwPj6Wy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC861A727D;
	Fri, 25 Jul 2025 02:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753410012; cv=none; b=Kob8IV/4opEDnZEr8htp+eLZ/Y8TZrh+6tc7DxQ98fmp/k1iOxXNizJJVNNjxSuQnZbxw9G2bQ1S7Bo0FsjiPqHHacCp7dR/meG6SL8q3ZN0HtzD5DzJAi9qnjxVJbocQ0tHYjiOU7ShY8QXQ9cbAKeq7kaQF0pQVfPbtwCFsA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753410012; c=relaxed/simple;
	bh=Jff5fOK3mT+GJlIyYbYmNpwK+HTTWoxX5E2yQ7JIIGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rPiVZGUacwdaO/OMJD6feloVt8G2Uq6dl/dJnPBLLH3ODjwHBu4KIMiB85Mg+XQIDbrBH9kxUe+h4WIJzY4dnocomKYsE5+aRfOVPSIRSn9jldfg0GNDXELMx1EIYfQMccUpRAINJjr/JvdzZIAfFP7G2v/r9yeEJCg6Ekv6VQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OzwPj6Wy; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-23636167afeso14224425ad.3;
        Thu, 24 Jul 2025 19:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753410011; x=1754014811; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rOtCvezxMdiF7Tvil/XsbTsGaqj7ACT+qoxrtuenXB0=;
        b=OzwPj6Wy+pz3Sdmgi4tfXlQEw4kajYZyrndGnAxeh4vTUR2C6jO3b+F0VrPrmHL1YB
         Eyt/8EnCGwkh2fi+RGtaV8PfU/UZmiwfOXlwDWbKSfyuicSm8r0d0iuPTwmduJR8IiW/
         CcUz00E+nqQjDafxpNiBs5Hjq9PbnFVa/rylfQHIBBb8I2IL8NR0OsgrrDemMgkCUX25
         rvU+RHUoPgxhM2RwOYYnjWRXb+Jyu4zAnC2960JT1jVWldsrnDX5sqx9lRVs43wgSjOy
         OpEJd1mp4Yaa/F6iDB+W2oGuZ60C6aEQA6juukIPFBEUHJDss04eYn+pjPmHfWvswng0
         3kyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753410011; x=1754014811;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rOtCvezxMdiF7Tvil/XsbTsGaqj7ACT+qoxrtuenXB0=;
        b=dG1QQTgm1EJV8XtXpPSVehBGkhF/vJA8VtKZxlQnG9jU4lcwGjf0PWXVMm+vwkNxiy
         bRka6OFd2hBj3Yl0mn0wFoEiIgViIcRJBP6mgHqYZbnIqKwJ195eNtdoDcMJ/1iR5PsV
         yazarGMT/WHAnzbTgQ6dFYlkI8RwZ0vTWUAljqVuDEYZTPel2cfVBUPTkP8NqaIEOjnL
         QCcCpU1EdGvd3ivpvBT10uEOdqJsQQSoOb6QH9Maesu+Qlazg8/MM0teXOJUbEiZXjpm
         IeOHgVuS/MckaN+LPCSmpA0isxdXD93XWADILdxm3hkGnfWLIzVKthC/qo2HH1al4XNH
         loVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvmcezumHfMnPCeMDnErPLuY99V6yqjCP39Obps3WCrcmCs3Wr6jrMOl2a2dgg64B25BlwDRzmc0XPW/FO@vger.kernel.org, AJvYcCVNqXic390eSYKqDEUD8RpdcnYMnGbqBKvLv5aqkFwOJkLvjrsTwTx2ec2zY/nsumO2RxM9JwAjw00=@vger.kernel.org, AJvYcCWVOxAXaNBTpYxKtCY2pFGrpZ9d5iHjUKscvxjjsDOiGVoQ/8ot+iq70Dhh+sY6hdTRIVA3hi6y2QJWh1a3ASYH@vger.kernel.org, AJvYcCXN3LXdtfig9cySqs1O3m/Cmc1dNhX9jAU00sKe0lrnIlT3SHGkRz5PP2BC4G2eynFKZb0WK/yF@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0xCsJzC1KjDdjDjBHcjbWFEAVwaKcgeoIy25L9xfCs3qlIUo/
	V44VsuVm3uldjkB3dbH01tzNdnHDi8vvXPnTEpbwxeuJ/yRilhkenFyO
X-Gm-Gg: ASbGncs92f1LMT+qsPi/XVjAhoXkQwVpXpbLX18KB8M/OPPgObQmBXW7jxYcCX1/Krr
	OjhLA4pNyIdotuYPLj62sE85/UCELGtBJHhCxfYxPge2kxo+5vFTEz+rr+/N5D28RfflwFurYW2
	p/eRpNj6mTRvFUasQcVxhPvkQD5W+xtQBe/srIJk8eF/74aWk/f9iAzN6TT90nNELEjoChdb2P3
	EEU0CFC/zTfZ73CzCaOQ6nZO955hI5Owb83WmybL5IVv5BOYoWX1klWYbSGcN/gZOZTR8jRzCRL
	cOAB2uhXp/Hjg2s0dJJtQKMKitUbPbQLT/Z2veG9qaUk633CsM2P6gQ7qQlTYNUPP1X2SU6EJ/I
	+UUzC9UBklKCGdVX32yJhbBxv4I0=
X-Google-Smtp-Source: AGHT+IHXr1IwD19y+W8O8fzifdFRib4MUFjdFa9ZTJmniUUOCMhnsjJDD2T/7zdf0+98jZgxKfRQSA==
X-Received: by 2002:a17:902:ccce:b0:234:c5c1:9b63 with SMTP id d9443c01a7336-23fb30ab826mr2891965ad.18.1753410010597;
        Thu, 24 Jul 2025 19:20:10 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fa48dc1a5sm25306485ad.141.2025.07.24.19.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 19:20:09 -0700 (PDT)
Date: Fri, 25 Jul 2025 02:20:01 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Petr Machata <petrm@nvidia.com>,
	Amit Cohen <amcohen@nvidia.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Alessandro Zanni <alessandro.zanni87@gmail.com>,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 3/3] selftests: bonding: add test for LACP actor
 port priority
Message-ID: <aILp0UfIyC5-NYrM@fedora>
References: <20250724081632.12921-1-liuhangbin@gmail.com>
 <20250724081632.12921-4-liuhangbin@gmail.com>
 <aIJDz3AgQtnzSR59@fedora>
 <20250724073501.1c0357c6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250724073501.1c0357c6@kernel.org>

On Thu, Jul 24, 2025 at 07:35:01AM -0700, Jakub Kicinski wrote:
> On Thu, 24 Jul 2025 14:31:43 +0000 Hangbin Liu wrote:
> > Should I drop this selftest as it needs the new iproute2 feature that has
> > not applied yet?
> 
> No need, I'll add the iproute2 patch in the CI.

Cool! Do you run CI for all posted patches?

I just found that I forgot to rebase the code to latest net-next, which will
have a conflict in include/net/bond_options.h... I see your email that the
net-next is closed. So I think we can just leave this patchset for reviewing.
I can post the next version after net-next re-open.

Thanks
Hangbin

