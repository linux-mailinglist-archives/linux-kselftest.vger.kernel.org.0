Return-Path: <linux-kselftest+bounces-4850-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE42857B7B
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Feb 2024 12:22:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 226B11F24D71
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Feb 2024 11:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6366D745FE;
	Fri, 16 Feb 2024 11:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y9la1mvM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE8E14281;
	Fri, 16 Feb 2024 11:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708082560; cv=none; b=fXPm7xoEidsbHeEo9HpuCSD6cT9zPfYfPNKK9HzT0iN8X7TCnJBExT0SevoE1nar7WKCgHDaXE6ai8EEotYWvBpMFINi41PoYAnBB8uhb4Kg2peRt+Ro8NCr+B4WhtXN8ifm0kBcL+5pdWgUFisfhdHJOLnkU98VrcpIa1+Ik1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708082560; c=relaxed/simple;
	bh=lFL3ilFFTMUWhr9p4abQ3pWR1A5Io/u9FEbYVZfSZp0=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=mhb6XFt/lzXFkJXJHOHuc7lsOdiobgwFZfflkZFM5o1RWbNHWrkGOdwXecPWJ7ZPcU5tKrJ1l3rYszMWHZ6HSL1IIBeUCPv54ahbYcq59iq9T/+B+rqsFen+TIXW0M3oFjzB2hwYlah6jT37GTU66oatEaymsgf4qq/SrsoCm9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y9la1mvM; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708082558; x=1739618558;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=lFL3ilFFTMUWhr9p4abQ3pWR1A5Io/u9FEbYVZfSZp0=;
  b=Y9la1mvMAzE3dLRuubFvf4f6B6tnxu1mFksG/MF6oK3tJneMjViaf8vF
   IHRzs5++3I2d230HUarcNHbC2ZJErpuFRSrQsNJ5yxGqK9bBfKhlDBS6A
   k+KxlxLYWi9kiC3Yr2eD0ZagfO7SElTy7/T1627EQwgwG911UQfwlkSnc
   xGzI5tDl503v7zw1hhDhCOmMPiKzdmxpqWzhQKMfrtDKw5/As7xl+VNxj
   sFDojfv9TOfAOOLH3vSix5zb6FqJdD+I4AoSWnMWTQVL8Ki+jLDUA9iRm
   Fy30SNmdQ2cdvRR5pssYDG+WDYm/oHw/wCCl9didAb5Xk+p/Qa8eH/y6M
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="2611647"
X-IronPort-AV: E=Sophos;i="6.06,164,1705392000"; 
   d="scan'208";a="2611647"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 03:22:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,164,1705392000"; 
   d="scan'208";a="3736000"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.94.248.234])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 03:22:35 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 16 Feb 2024 13:22:30 +0200 (EET)
To: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
cc: Reinette Chatre <reinette.chatre@intel.com>, shuah@kernel.org, 
    fenghua.yu@intel.com, linux-kselftest@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 5/5] selftests/resctrl: Add non-contiguous CBMs CAT
 test
In-Reply-To: <ce175d1ec6ed158cf37c08dc1ec6a87038ad2d9b.1708072203.git.maciej.wieczor-retman@intel.com>
Message-ID: <849e5051-d024-d7c7-1653-77facc5eb1a8@linux.intel.com>
References: <cover.1708072203.git.maciej.wieczor-retman@intel.com> <ce175d1ec6ed158cf37c08dc1ec6a87038ad2d9b.1708072203.git.maciej.wieczor-retman@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1009549301-1708082550=:1097"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1009549301-1708082550=:1097
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 16 Feb 2024, Maciej Wieczor-Retman wrote:

> Add tests for both L2 and L3 CAT to verify the return values
> generated by writing non-contiguous CBMs don't contradict the
> reported non-contiguous support information.
>=20
> Use a logical XOR to confirm return value of write_schemata() and
> non-contiguous CBMs support information match.
>=20
> Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-1009549301-1708082550=:1097--

