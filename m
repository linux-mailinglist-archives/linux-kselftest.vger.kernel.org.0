Return-Path: <linux-kselftest+bounces-43483-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3272EBECCDB
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Oct 2025 11:53:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 18EFB4E3CC5
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Oct 2025 09:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5DF928688E;
	Sat, 18 Oct 2025 09:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gQJ/gup4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746681DFF0
	for <linux-kselftest@vger.kernel.org>; Sat, 18 Oct 2025 09:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760781179; cv=none; b=soRpsI/oRZhFzs6CIrkDd4LD+zIowpjwm7xAVcwS4lAV7hZiTqP5uV0MfrBIU7lsWQAsCt84sBc/lBDmimT7YxRxhZD2xlgi9QEz1Yj4eh4hchbcvaucv9phNEL54d6EAshsY9IqzJ+l3M9ud44nL7jLq363S07sfZHOH9Tz2sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760781179; c=relaxed/simple;
	bh=Y45xI99lNq3bg0jwaIprFYNlGwqcmi0LDhG9j9uVIfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H3y8w+R1AqSzipDncdRcc0Olh2T0+1SoUS5NJqadacwlaMSKKt/K+stApSvgBsyYewIOSrGKP7fPmmHPj1ZMgORH3MdGag+mteZPVWecrcSNSYGbnYWLhllBy1uiS5IvU5Qt+aWyAOmsK+rzC5ewkW9GHaltBYhBsDLn1qj2Fpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gQJ/gup4; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b550a522a49so2245778a12.2
        for <linux-kselftest@vger.kernel.org>; Sat, 18 Oct 2025 02:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760781178; x=1761385978; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pDggDaVozKMDJ3kUVYug72mUZBMi1Sh/R7yLQU2yJos=;
        b=gQJ/gup4fIzOsvECYg9XQJPn12AJ4F7Vh0CFnplJnb/24uhmoA9cpETsFxw84EFFIE
         JDQHY0GPTtqEWIoa90HWlgSjeba/LSs9a2CJM9/8Y9P6s+9HiLiL6Ojc3WD4a15j6jxe
         2qZ7fbDiAbiCdCfjfXs8a4wWnV04AzHcHPc70njQNgg6GXmU3EbxknSSWj7gTyqgzhlU
         kNSOnkWDxqSvXzRWDCHFyIUmNXyGONeII21ppbfLdDki3UKWMJuwZMVKJn0KICuyIk39
         YVKqs4BWGUf1jZmn17f5FkhNAFn14f77nf6Ee5y3V2KYjVhpBC5sVRlUmR7/jYMU7cO4
         XALA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760781178; x=1761385978;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pDggDaVozKMDJ3kUVYug72mUZBMi1Sh/R7yLQU2yJos=;
        b=PPIA7LF/VYEoGTssXGvM9YHkWB+vJtwk3xDpnV/ZIllSJ6Tw+GMkezaL9U502LmlHV
         7qi4HGtoxZTcQAU33AUZ+SmJK5pWscJieLM9ul6vrXmSnNGAlUT6NDceqLscAFoVbnwR
         jWplmzqtCJ7+Szt+M/PqkidJuyt1+JTU/eUDBDfGJ7AtykPw6dZMKUw4iyPJ97n9k/qi
         SSzQuoV+fHHpFdrImlgckA69QUeCGTpxmiu+NOrELGnrZxSLsdB8GXjsxalcpB/vkopA
         R2Rm0qn0YNdcaFrEQ6jbB+XVjfRa7rvFnzFmstF7TUTEezjfH3+GEVfu0iN+2wymrgsg
         e/Ww==
X-Forwarded-Encrypted: i=1; AJvYcCWpzdALp6Nzkl36FPtsKGrIPoDrT/50iwCw4pm9UnKVFLPPIlS4PZNlstyW+4x/h0DA2PJuBSS21EbzhWcLTi4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb9RSr8R4mGjbW13Qx4ZAihG/9AjxkkfBfYl7RmLjKBLXjQBMD
	5wCBIOVbOY3EILbx0mRCbi5ga21z1AFUqqcmzk1Peny7PU0NT1XVgZ9B
X-Gm-Gg: ASbGncsVSBhb8V7HIIPuC6O+3sqNKfgo/72iUrmhYg0Ma3qoNGoo9aPKmq5Uavjo743
	rRME9q1FDlsWNjbfy53WhKyPj/DLc2x8l3f29FftQ7vggR+d8LWnZDbIcyOC8gmhxbW7RKDYV7i
	k6J70UBVvjtlQYMRSlQc9wKSINFl4VI4j+S9f2nk5jgE3XGxMkOg8cmdKdYHKDdaJv7tkFeOA/n
	2hjA+nNL36mLXuMnJY6DifMxP9ohB1eSzwrLvpi9/Y8dvmSkO1yT/J9VrEtmGGgFcKN0/8BSPf2
	W5hmCrSDq+qMa1jM+/e8Hl8SUpzsK0PwbZw9WH5imqFwTUVwdzyFl72ojcnMTuPT4GtH7JAuo7Q
	gBzQBT4UzkfW6R0k4FHSVfERrxuL4ZJAccCJdc+d84gNOrHlhjG5g2GZpNfob3WokKl1vBnxBus
	4AgtSK
X-Google-Smtp-Source: AGHT+IHjT3vtmC4Zp9pVe+m8KhsOPQzDkwDC4erYLJEc3KHShsIBzjOCwBE0zfE8NF/Ki7mwy/01Qg==
X-Received: by 2002:a05:6a20:a123:b0:324:6e84:d170 with SMTP id adf61e73a8af0-334a856d518mr10185866637.15.1760781177656;
        Sat, 18 Oct 2025 02:52:57 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a764508b0sm2290657a12.0.2025.10.18.02.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 02:52:56 -0700 (PDT)
Date: Sat, 18 Oct 2025 09:52:49 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Nikolay Aleksandrov <razor@blackwall.org>, netdev@vger.kernel.org,
	Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stephen Hemminger <stephen@networkplumber.org>,
	David Ahern <dsahern@gmail.com>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next] bonding: show master index when dumping slave
 info
Message-ID: <aPNjcWo8G3tTpin0@fedora>
References: <20251017030310.61755-1-liuhangbin@gmail.com>
 <0be57e07-3b90-44f7-85d5-97a90ac13831@blackwall.org>
 <7quap7umeeksodg62bbv4ob4344edplb7f33yiebs2hvhrrdvf@wndrzz7rxi7v>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7quap7umeeksodg62bbv4ob4344edplb7f33yiebs2hvhrrdvf@wndrzz7rxi7v>

On Fri, Oct 17, 2025 at 11:56:55AM +0200, Jiri Pirko wrote:
> Fri, Oct 17, 2025 at 08:10:09AM +0200, razor@blackwall.org wrote:
> >On 10/17/25 06:03, Hangbin Liu wrote:
> >> Currently, there is no straightforward way to obtain the master/slave
> >> relationship via netlink. Users have to retrieve all slaves through sysfs
> >> to determine these relationships.
> >> 
> >
> >How about IFLA_MASTER? Why not use that?
> 
> It's been there for a decade. Plus is, it exposes master for all
> slave-master devices. Odd that you missed it.

Once, I wanted to find the slaves from a master interface but couldn’t. So I
added it to my to-do list. Later, I noticed that the master information was
already available in the slave, but I forgot about it after long time.
Recently, when I reviewed my to-do list, I realized that printing all slaves
from the master interface seemed impractical. So I tried to list the master
information in the slave again — and forgot about IFLA_MASTER...

Hangbin

