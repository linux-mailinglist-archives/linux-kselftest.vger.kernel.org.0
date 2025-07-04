Return-Path: <linux-kselftest+bounces-36507-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB32AF884A
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 08:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF5734A791C
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 06:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08B22620CB;
	Fri,  4 Jul 2025 06:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="J2RaqS1z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from jpms-ob01-os7.noc.sony.co.jp (jpms-ob01-os7.noc.sony.co.jp [211.125.139.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA56E1FDA;
	Fri,  4 Jul 2025 06:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.125.139.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751611828; cv=none; b=LNJsCZ53iN5AnU/gKn/q+njtvQVloTH+ethPPAZZe94tvOhpDDue8UnXlBWGMuhW+cliUSdf9lgUjv8Bh+zcGTH/FsbeH4+LU/1jKW7FK92RKh1AowkRtsBZVompzceLBIRu9VK2mS4RHE2vR/SwjD7ZnLbybSiIrD+yFVmnS9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751611828; c=relaxed/simple;
	bh=NLVQJy7XmMi2i+Aam1tLzS56P12ixeAmwTmXI0IprDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m8ffMdLz5M375SOq9yzAXABREv2npVUHsJrs8syQmYvkfhGgdFdrjVCwQNPZXKFl3CQ6cKZqzcNXa6EHl8KE+MyJzZKk6Pilg72IhvYgHVLoSAFuEuvPRnAMxFD/Xz8ugG2mYD10Uzd55UjePDM71scFOTYHAqIkJPLe1g8eXEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=fail smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=J2RaqS1z; arc=none smtp.client-ip=211.125.139.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=sony.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=sony.com; s=s1jp; t=1751611824; x=1783147824;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=wdmGAeV1gxh9QGTBIPnqXDaIxBsTlpQBDSJxrd2znmY=;
  b=J2RaqS1zbf7L2oUIakWruewEBiN1Az5J9TMEQf/CZBSEAtRH+LnVmtsE
   VsG1unVxsI3jGLZ4XYY7J5mFAOjAYRXskhrS2uG6e9xzRFB7U1jFTh++X
   v0j6LWaotMT9BhxZBtn4/K9eMpTgjdjy7sK+Rk+aSKjRP6f1oIeoBROxC
   UQYdum6dEVjGDXqtxzr4GCGfWSoX8SJGb7Rdy6ot8xWud1EBbG1QqZzf2
   1DfXl+lSTAmm0ew2UpITbKYYEY1nFk1xOg4TszpFBLnRmo7jIZlCzkHq3
   6Lrs0InNV9ehvU/7xomoD7PyN9K0Omim0VcAkTXA9feErpT7zBsNssZEY
   A==;
Received: from unknown (HELO jpmta-ob02-os7.noc.sony.co.jp) ([IPv6:2001:cf8:acf:1104::7])
  by jpms-ob01-os7.noc.sony.co.jp with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2025 15:50:16 +0900
X-IronPort-AV: E=Sophos;i="6.16,286,1744038000"; 
   d="scan'208";a="4627854"
Received: from unknown (HELO JPC00244420) ([IPv6:2001:cf8:1:573:0:dddd:eb3e:119e])
  by jpmta-ob02-os7.noc.sony.co.jp with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2025 15:50:16 +0900
Date: Fri, 4 Jul 2025 15:49:58 +0900
From: Shashank Balaji <shashank.mahadasyam@sony.com>
To: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
	Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	Shinya Takumi <shinya.takumi@sony.com>
Subject: Re: [PATCH v2] selftests/cgroup: improve the accuracy of cpu.max
 tests
Message-ID: <aGd5lrUvm9Bhh-b8@JPC00244420>
References: <20250701-kselftest-cgroup-fix-cpu-max-v1-0-049507ad6832@sony.com>
 <20250703120325.2905314-1-shashank.mahadasyam@sony.com>
 <l3sal6zkvo4lqnfs6fepxytnrmqmqwfvtxudnjm53oigtuatpd@7czfeursgwyh>
 <aGcf0Prl-hVX2j4Q@JPC00244420>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aGcf0Prl-hVX2j4Q@JPC00244420>

On Fri, Jul 04, 2025 at 09:26:56AM +0900, Shashank Balaji wrote:
> > >  tools/testing/selftests/cgroup/test_cpu.c | 63 ++++++++++++++++-------
> > >  1 file changed, 43 insertions(+), 20 deletions(-)
> > 
> > 
> > > -	user_usec = cg_read_key_long(cpucg, "cpu.stat", "user_usec");
> > > -	if (user_usec <= 0)
> > > +	if (usage_usec <= 0)
> > >  		goto cleanup;
> > >  
> > > -	if (user_usec >= expected_usage_usec)
> > > -		goto cleanup;
> > 
> > I think this was a meaningful check. Not sure if dropped accidentally or
> > on purpose w/out explanation.
> > 
> > After that's addressed, feel free to add
> > Acked-by: Michal Koutný <mkoutny@suse.com>
> 
> Sorry about that. I dropped it accidentally. This check should be okay,
> right?
> 
> 	if (usage_usec > expected_usage_usec)
> 		goto cleanup;
> 
> 1. We don't need to separately check user_usec because it'll always be
> less than user_usec, and usage_usec is what's directly affected by
> throttling.
> 2. I changed the >= to > because, not that it'll ever happen, but we can
> let usage_usec = expected_usage_usec pass. Afterall, it's called
> "expected" for a reason.

Hmm, here is something interesting. The following patch adds printfs to the
existing code to see what user_usec, usage_usec, the expected_usage_usec used in
the code, and the theoretical expected_usage_usec are. On running the modified test
a couple of times, here is the output:

	$ sudo ./test_cpu
	user: 10485, usage: 10485, used expected: 1000000, theoretical expected: 10000
	ok 1 test_cpucg_max
	user: 11127, usage: 11127, used expected: 1000000, theoretical expected: 10000
	ok 2 test_cpucg_max_nested
	$ sudo ./test_cpu
	user: 10286, usage: 10286, used expected: 1000000, theoretical expected: 10000
	ok 1 test_cpucg_max
	user: 10404, usage: 11271, used expected: 1000000, theoretical expected: 10000
	ok 2 test_cpucg_max_nested
	$ sudo ./test_cpu
	user: 10490, usage: 10490, used expected: 1000000, theoretical expected: 10000
	ok 1 test_cpucg_max
	user: 9326, usage: 9326, used expected: 1000000, theoretical expected: 10000
	ok 2 test_cpucg_max_nested
	$ sudo ./test_cpu
	user: 10368, usage: 10368, used expected: 1000000, theoretical expected: 10000
	ok 1 test_cpucg_max
	user: 10026, usage: 10026, used expected: 1000000, theoretical expected: 10000
	ok 2 test_cpucg_max_nested
	$ sudo ./test_cpu
	user: 10541, usage: 10541, used expected: 1000000, theoretical expected: 10000
	ok 1 test_cpucg_max
	user: 11040, usage: 11040, used expected: 1000000, theoretical expected: 10000
	ok 2 test_cpucg_max_nested

So, both user_usec and usage_usec exceeding the theoretical expected_usage_usec
is not uncommon. The "fail if usage_usec >= expected_usage_usec" check in the
existing code only really works because of the (wrong) large expected_usage_usec
used.

So I think the best we can do is check if usage_usec is close to expected_usage_usec
or not, and not require usage_usec to be less than expected_usage_usec.

diff --git i/tools/testing/selftests/cgroup/test_cpu.c w/tools/testing/selftests/cgroup/test_cpu.c
index a2b50af8e9ee..14c8c7b49214 100644
--- i/tools/testing/selftests/cgroup/test_cpu.c
+++ w/tools/testing/selftests/cgroup/test_cpu.c
@@ -679,6 +679,9 @@ static int test_cpucg_max(const char *root)
        if (user_usec >= expected_usage_usec)
                goto cleanup;
 
+       printf("user: %ld, usage: %ld, used expected: %ld, theoretical expected: 10000\n",
+               user_usec, usage_usec, expected_usage_usec);
+
        if (values_close(usage_usec, expected_usage_usec, 95))
                goto cleanup;
 
@@ -739,6 +742,9 @@ static int test_cpucg_max_nested(const char *root)
        if (user_usec >= expected_usage_usec)
                goto cleanup;
 
+       printf("user: %ld, usage: %ld, used expected: %ld, theoretical expected: 10000\n",
+               user_usec, usage_usec, expected_usage_usec);
+
        if (values_close(usage_usec, expected_usage_usec, 95))
                goto cleanup;
 
@@ -758,13 +764,13 @@ struct cpucg_test {
        int (*fn)(const char *root);
        const char *name;
 } tests[] = {
-       T(test_cpucg_subtree_control),
-       T(test_cpucg_stats),
-       T(test_cpucg_nice),
-       T(test_cpucg_weight_overprovisioned),
-       T(test_cpucg_weight_underprovisioned),
-       T(test_cpucg_nested_weight_overprovisioned),
-       T(test_cpucg_nested_weight_underprovisioned),
+       // T(test_cpucg_subtree_control),
+       // T(test_cpucg_stats),
+       // T(test_cpucg_nice),
+       // T(test_cpucg_weight_overprovisioned),
+       // T(test_cpucg_weight_underprovisioned),
+       // T(test_cpucg_nested_weight_overprovisioned),
+       // T(test_cpucg_nested_weight_underprovisioned),
        T(test_cpucg_max),
        T(test_cpucg_max_nested),
 };


