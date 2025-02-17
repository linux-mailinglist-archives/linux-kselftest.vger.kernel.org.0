Return-Path: <linux-kselftest+bounces-26781-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 266DFA384FA
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Feb 2025 14:44:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D27FB1888DF5
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Feb 2025 13:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 587EB21CC6E;
	Mon, 17 Feb 2025 13:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="N47CXBfN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BAE613AA5D;
	Mon, 17 Feb 2025 13:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739799775; cv=none; b=hIDcBuU/E5Ne6ijlsg8WjRnVs5IGXtrsZJJpvzLVS0rEJXIDn1ysyhWCt7rhw+U/MlETz8FIEW0SiEkJwKKIUVKQ6PmFSQNrDgr5+9xz48dkRwJusqFaqyg7wAh/tJXDtR8wj1wpnABZYlEcKwL+fnKclPQba9jiyzBM72T+I0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739799775; c=relaxed/simple;
	bh=PJJl56wGhGbOSi7fd/XKLyf03o1+wNsu5UVIOH9q0YA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IwMlHoQ3R/nLVzVKmKyipUTuQp2PGNt6v73EOKA0yReCZ6JlQ+OTTYSg+AluKzOBkCebmL0yfQsuaKMdQKeCpb45dPbWx9J+6kSErF10yPvpiZdZocJx/YCv+sV5VoGD1Hy4ADMa4+DwmOeFiZnnuVL3o5iNR6fa/YyXJh5PsDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=N47CXBfN; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51HA8YHI008970;
	Mon, 17 Feb 2025 13:42:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=wUe4fKrx5o4/Zt5xfEBsdlqjck4Hlq
	HFST87BHRi/q8=; b=N47CXBfN4+2yzZ4J8YTD04o0EeMWbLKhXJ6RFbLJgEvDvW
	RqKbiwAcuUN0p6YVqTKUeJlRiHa+pvuKaPqC+UnArV6cuzAo6JY30xwc6JRtsA75
	YSHiCv0l38yFPHgelwyqUTIhAKcs4EpHGKY61DraX9ADM5+5VgnK9PRDnLr2J6hG
	puAij6E19Q7lqHyXUBaHRTf5DCKXikZKbdrzYx6+Y7Ce/3L7P7WgDV+/ZUCKMIUp
	26MxLm0+qqXLDP+g4T1hQk9RuqW81ohqDVi7AhIkBCbrGDft+ZDGvDvxcbf+pINs
	QQqpnAgUqYthQOFhE5ocOCwf4Y+eWELGVhiptWHg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44ujutmfk0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Feb 2025 13:42:49 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51HCleAg004038;
	Mon, 17 Feb 2025 13:42:48 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44u68np9uv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Feb 2025 13:42:48 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51HDgkGD43909604
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Feb 2025 13:42:46 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4339320043;
	Mon, 17 Feb 2025 13:42:46 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CF3FF20040;
	Mon, 17 Feb 2025 13:42:45 +0000 (GMT)
Received: from osiris (unknown [9.171.53.224])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 17 Feb 2025 13:42:45 +0000 (GMT)
Date: Mon, 17 Feb 2025 14:42:44 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 2/2] selftests/ftrace: Make uprobe test more robust
 against binary name
Message-ID: <20250217134244.21424A57-hca@linux.ibm.com>
References: <173625185823.1383744.4020760882101555349.stgit@devnote2>
 <173625187633.1383744.2840679071525852811.stgit@devnote2>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173625187633.1383744.2840679071525852811.stgit@devnote2>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: nr19yrfXbNrp8eyhPihgTjLj0320_c_Q
X-Proofpoint-GUID: nr19yrfXbNrp8eyhPihgTjLj0320_c_Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-17_05,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 priorityscore=1501 clxscore=1011 mlxlogscore=789
 malwarescore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502170117

On Tue, Jan 07, 2025 at 09:11:16PM +0900, Masami Hiramatsu (Google) wrote:
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Make add_remove_uprobe test case more robust against various real
> binary name.
> Current add_remove_uprobe.tc test expects the real binary of /bin/sh
> is '*/bin/*sh', but it does not work on busybox environment.
> Instead of using fixed pattern, use readlink to identify real binary
> name.
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  .../ftrace/test.d/dynevent/add_remove_uprobe.tc    |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_uprobe.tc b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_uprobe.tc
> index a275decdc880..86c76679c56e 100644
> --- a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_uprobe.tc
> +++ b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_uprobe.tc
> @@ -6,8 +6,10 @@
>  echo 0 > events/enable
>  echo > dynamic_events
>  
> +REALBIN=`readlink -f /bin/sh`
> +
>  echo 'cat /proc/$$/maps' | /bin/sh | \
> -	grep "r-xp .*/bin/.*sh$" | \
> +	grep "r-xp .*${REALBIN}$" | \
>  	awk '{printf "p:myevent %s:0x%s\n", $6,$3 }' >> uprobe_events

This test fails on s390, not because of this change, but since the
test seems to assume that the entry point of /bin/sh is at offset 0;
or at least there is some code that is executed at least once at
offset 0; but that is not the case (at least) for s390.

Not sure how this can be addressed. Using "readelf -f" to get the
entry point address of the executable and use that for the uprobe
would work, but it would also add a dependency to binutils for the
ftrace selftests, which doesn't exist yet, as far as I can tell.

Would it maybe an option for architectures to opt-in to use readelf
and skip the test (exit_unsupported) if readelf is not available?

