Return-Path: <linux-kselftest+bounces-2179-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03C2E8184B8
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Dec 2023 10:46:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 812F2284D0E
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Dec 2023 09:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D95014017;
	Tue, 19 Dec 2023 09:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jy/1nwU7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9F213FFB;
	Tue, 19 Dec 2023 09:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BJ97Px2030485;
	Tue, 19 Dec 2023 09:45:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=Ms7ur4E7a6ZJUk/bHA5Ykjz39zDPiKYSt7oHdQpIPPI=;
 b=jy/1nwU7wMQnFl6CpxuS3EpDYjjwObCIz+RgC57cstzhAjBC921/9HXn6IbhjIFRVPvn
 MDOpgERvSeMszWsPibrwuW4qr7qY1lonXQudwAzqNUXbmEJKvYSGyTT7sy++GSvdtZsx
 syxxRofn8cHOH9yNVVP8XAAADpIRItv2ayYi2ENDDbAwCIgvfyWqoMQCBdTuBVp5mAg/
 OGd+q+E11v84HfUePzX7s5dZluu7XDkgQ1E+8Mr2GQO3WTwbuiyFd8yq6FcrSp1izCyS
 7akyi5HVhtzCvyX/Xza5ZEazV7fUyXmJpYOQyoyQ2hQYj5U+JcTaghCrkdEGaB09qxcb VA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v388xs03x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Dec 2023 09:45:36 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BJ98iEe001724;
	Tue, 19 Dec 2023 09:45:36 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v388xs02d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Dec 2023 09:45:35 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BJ7nQOn014071;
	Tue, 19 Dec 2023 09:45:33 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3v1qqk6m1b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Dec 2023 09:45:33 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BJ9jVHT25886988
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Dec 2023 09:45:31 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5E21B2004D;
	Tue, 19 Dec 2023 09:45:31 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BDABA20043;
	Tue, 19 Dec 2023 09:45:30 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.171.6.112])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 19 Dec 2023 09:45:30 +0000 (GMT)
Date: Tue, 19 Dec 2023 10:45:29 +0100
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Joe Lawrence <joe.lawrence@redhat.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>,
        linux-kselftest@vger.kernel.org, live-patching@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: Re: selftests/livepatch fails on s390
Message-ID: <ZYFmOfFgsOdeikec@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <ZYAimyPYhxVA9wKg@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
 <cf087c7e-d24d-5cee-eadd-dd1fe26efe39@redhat.com>
 <ZYDLZkXdJ22AXtLW@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZYDLZkXdJ22AXtLW@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: NR-FdXTkh4blAX33UwBTX-3agsjxwepP
X-Proofpoint-GUID: FKrE8q9QEkDHMrS0xBKqlLC2w5BS57B7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-19_05,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 spamscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0
 phishscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 mlxlogscore=676
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312190072

On Mon, Dec 18, 2023 at 05:44:54PM -0500, Joe Lawrence wrote:

Hi Joe!

...
> > If we pre-trim the timestamps, the output is what we expect:
> > 
> >   $ comm --nocheck-order -13 \
> >       <(sed 's/^\[[ 0-9.]*\] //' /tmp/A) \
> >       <(sed 's/^\[[ 0-9.]*\] //' /tmp/B)
> >   message four
> > 
> > however, I'm not sure if that fix would easily apply.  It looks like I
> > provided a disclaimer notice in check_result():
> > 
> > 	# Note: when comparing dmesg output, the kernel log timestamps
> > 	# help differentiate repeated testing runs.  Remove them with a
> > 	# post-comparison sed filter.
> > 
> > so I wonder if comm will get confused with repeated selftest runs?

I would think so. AFAICT even a single run would produce duplicate lines.

...
> This is *very* lightly tested, but I thought maybe you could give it a
> spin.  Hopefully it's less brittle than diff/comm strategy.

That seems to be working. However, please see below.

...
> @@ -280,7 +268,13 @@ function set_pre_patch_ret {
>  function start_test {
>  	local test="$1"
>  
> -	save_dmesg
> +	# Dump something unique into the dmesg log, then stash the entry
> +	# in LAST_DMESG.  The check_result() function will use it to
> +	# find new kernel messages since the test started.
> +	local timestamp="$(date --rfc-3339=ns)"
> +	log "livepatch kselftest timestamp: $timestamp"
> +	LAST_DMESG=$(dmesg | grep "livepatch kselftest timestamp: $timestamp")

Not sure if it not paranoid mode, but still..
If the 'log' call is guaranteed synced? AKA would 'grep' always catch the line?

And yeah.. if the log output is pushed away (e.g by a crazy-dumping concurrent
logger), then nothing here would work. But this is not a new problem, so just
my two cents.

>  	echo -n "TEST: $test ... "
>  	log "===== TEST: $test ====="
>  }

Thanks!

