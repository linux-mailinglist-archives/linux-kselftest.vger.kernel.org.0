Return-Path: <linux-kselftest+bounces-4431-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 651AB84F673
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 15:05:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFD37B21635
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 14:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0FDD692E1;
	Fri,  9 Feb 2024 14:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lxvS4DpR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC7567E8B;
	Fri,  9 Feb 2024 14:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707487487; cv=none; b=lDJ0jTfzPjrE3e97ZgttBPNqNSdLGawNA61wYJHzvd7SF1SJBl4a0hisP0wsNUuRDkJr1sh5nz/fXpec1vqemOIfkV10nCbOTEz6bTP5ozITkDGLMO+PEDYhzzFAvaOQFHZ2LA6twL+LbB7EOTBvhH+anI/2gWmEwGf5zZRob2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707487487; c=relaxed/simple;
	bh=k9nrViSqw/rb1+/LDrZiy4SVsq+h2sUxOmJ1e2jv7UY=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=hKC4PDmP/FJDke3GOVpqjcDXr+phLBE67MLCzxNH9j3WYze9NrovNAoQeK5xcLtyZopfPRjypEdCea9KwdtZN54vWF6P68pzFDI/8ZSFiYccfvOAUYZseQrP2yVudNy5oRtE87seI5sArGCT8h1yZLxFBN+rgAn65rgt4EDKspA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lxvS4DpR; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707487487; x=1739023487;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=k9nrViSqw/rb1+/LDrZiy4SVsq+h2sUxOmJ1e2jv7UY=;
  b=lxvS4DpRzirUpcKfwG5VWAJ+pXxyk3F477imyiP9OzdpRug/sVqf9bzD
   8oO/kIxXM2M2CHJLckagmkWBW24MzwtMWZLIlmPdsOm/HK10p2elYi9xJ
   fW7LMC9yP144CdRxhmS6+XT5rZn+0ZB4lUTFHqUJtKEbLplhIGr7lGVoI
   ZTag3oSaiqlSKDf1QVuyDhSU81IdhP0plSHkzahTYp2LmJkql1vwl3SWs
   M5w8QxTcTwZGOy2yZB3WUG9YxSLSINxsNpUBT71ogfFL+PbLC5QeDq6+I
   xrTBO7fL86RZbi6IMH20bZFafIISXmoT/spZAqN784vYGOd1J3Jy5oUW6
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="18940790"
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="18940790"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 06:04:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="1946721"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.33.226])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 06:04:41 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 9 Feb 2024 16:04:36 +0200 (EET)
To: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
cc: Reinette Chatre <reinette.chatre@intel.com>, shuah@kernel.org, 
    fenghua.yu@intel.com, linux-kselftest@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 5/5] selftests/resctrl: Add non-contiguous CBMs CAT
 test
In-Reply-To: <2c1011e7630605365b67caa6ddfe4e8ee2ba5bff.1707487039.git.maciej.wieczor-retman@intel.com>
Message-ID: <c89f5d5d-4094-16e8-64f3-333d55ae7922@linux.intel.com>
References: <cover.1707487039.git.maciej.wieczor-retman@intel.com> <2c1011e7630605365b67caa6ddfe4e8ee2ba5bff.1707487039.git.maciej.wieczor-retman@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-606766491-1707487476=:1157"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-606766491-1707487476=:1157
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 9 Feb 2024, Maciej Wieczor-Retman wrote:

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

--8323328-606766491-1707487476=:1157--

