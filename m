Return-Path: <linux-kselftest+bounces-46908-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41894C9CC1F
	for <lists+linux-kselftest@lfdr.de>; Tue, 02 Dec 2025 20:24:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01B003A8BCF
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Dec 2025 19:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4847A2D9782;
	Tue,  2 Dec 2025 19:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KrOiT/Cl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8EE2C327C
	for <linux-kselftest@vger.kernel.org>; Tue,  2 Dec 2025 19:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764703472; cv=none; b=qIQswM1Fh7f8TMDKHmtqWw/k7vONcPM/x1g2E0ZvHOFKkviDabX3w/nmQMAvfUVjQFuLKokQWem+ye95VpUcjLtZ23nBAQQRX5iau4QKDAKAVq5z5vtNSiLIYCaC7GWxz8DcBJYhaG84nUMAABW0H80xosuwGXFvS3s1Eqa8Ob0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764703472; c=relaxed/simple;
	bh=ZAVNffKBxs3Sh4FiMDJw2UR7G3mhGmzTiM45fYl42Nw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aKtZkj9kiG2PqkeOZJ8+WLCGAZoNdRmPF+aCNCJD5NuKcKuq58KKXGWw1zfwtR3EelWbwtBkI6XcN4Ntj9WIskgw6eAW39MhUILCsfEJwy3gS6rJmvhNWrZwKiDl/VXqYf+Ayew5RW2kFvpbM8XPmPVABegsDzCrYi6JE+ugZzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KrOiT/Cl; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 2 Dec 2025 11:24:22 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764703468;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ItDOClnB9rHsRl2j3htJV8Dizb51nQfpKAcRcZrVh4I=;
	b=KrOiT/ClG7fAeDuTNt17HlI27GXbwiHrL41ptmFG1CNbpiCwKHmfjWuD4rUJVs0EsWK/04
	7rYZMhE20goaUzkb95rBUjJNuzUyT6QF3x9E2kjUnjQJ79XgLNmqRobMLNVzEoWI4bb/Qg
	reK/8rrRfsl9dz+aSGsHS9e9nrL+fss=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Guopeng Zhang <zhangguopeng@kylinos.cn>
Cc: tj@kernel.org, hannes@cmpxchg.org, mhocko@kernel.org, 
	roman.gushchin@linux.dev, mkoutny@suse.com, muchun.song@linux.dev, lance.yang@linux.dev, 
	shuah@kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/3] selftests: cgroup: Add cg_read_key_long_poll() to
 poll a cgroup key with retries
Message-ID: <bqbyraqz6ztwxd5hysw4ufttbb3ev463su4wyhipsuvau5bw7n@gzxrmua2aldf>
References: <20251124123816.486164-1-zhangguopeng@kylinos.cn>
 <20251124123816.486164-2-zhangguopeng@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251124123816.486164-2-zhangguopeng@kylinos.cn>
X-Migadu-Flow: FLOW_OUT

On Mon, Nov 24, 2025 at 08:38:14PM +0800, Guopeng Zhang wrote:
> Introduce a new helper function `cg_read_key_long_poll()` in cgroup_util.h.
> This function polls the specified key in a cgroup file until it matches the expected
> value or the retry limit is reached, with configurable wait intervals between retries.
> 
> This helper is particularly useful for handling asynchronously updated cgroup statistics
> (e.g., memory.stat), where immediate reads may observe stale values, especially on busy systems.
> It allows tests and other utilities to handle such cases more flexibly.
> 
> Signed-off-by: Guopeng Zhang <zhangguopeng@kylinos.cn>
> Suggested-by: Michal Koutný <mkoutny@suse.com>

Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>

