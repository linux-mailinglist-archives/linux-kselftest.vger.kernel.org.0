Return-Path: <linux-kselftest+bounces-14559-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C9649434F6
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 19:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E86291F232C7
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 17:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7153A1BC086;
	Wed, 31 Jul 2024 17:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bBDlgdJq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="K2QJAByw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD8F1B140E;
	Wed, 31 Jul 2024 17:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722446699; cv=fail; b=HvyZcoU9LnL+wVQhcVXcEkqKGTR+2NnH2VrmJ1H6VO/U37sqCdAXPxX1ZCPOgXmLRF0AvTk5GrXJF9KlJemzrAY+ohvKIHZAwWvS/9VH2m2dERm8nMCE6Bx1QPhHdGPAEpEP5VPNXV9WaKtTc8lDBGtuxKdepCFfP0lZMc3Kobc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722446699; c=relaxed/simple;
	bh=+RdY01k4mvur/dbIKfUi/+o6Yn/sgkZQtGTU2s5Dp5M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XP9EAS7Z0TTD7g4ZNIDFeoPrtJ5N2H6eZatGu7FksIgPs9MlIZfz0pf+mLdjtId1+CHvEXqC0t88YfHk4YMHhWtY0ti/7R8x3Pq6bcdeO/C09Rv1ElnIQsQsqIocNqlxpNqWCbCfFqaE0VrxA8WJsRTsq5VaOJbkuWiUKG3UmR4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bBDlgdJq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=K2QJAByw; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46VHBYov013033;
	Wed, 31 Jul 2024 17:24:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=/hf5/IW/VTsUH+jb7nM+VflxzDL0g/VgQKHKYwNsMIU=; b=
	bBDlgdJqirQTao1KiFa4/dOMM+3rZJ1BcWHkgRv6MWebCoSJcGL5ycOBI1+ak0uY
	z7mlccsn3aRX3TRnON5uRt4fzc9cTf7myqa7o9DCEt1MdKvyXqR5ThDSRRiGerTF
	wh/CnePdgGv71L9ArZ0f8FFPbp7i2ed9rzBN5/iZbE+R3vbX/9d+tZm/UpLOjkF1
	KifHphPCa7uV/9quQFP+I+50IQnttaJUf7Jd5/7PpXz5zg6FnQRlwA9VQwjRhxi5
	BI5xgPlSLs0X6mCcRBkVVB8F+rZs9Lo0eUam9+QIh+BVL9kMkFEMVLXvlNfHamAT
	1N9BScid5/0B2wW4gzfffQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40mqacqw65-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 Jul 2024 17:24:22 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46VGZ8ax028989;
	Wed, 31 Jul 2024 17:24:21 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2174.outbound.protection.outlook.com [104.47.73.174])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40qmprwn3p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 Jul 2024 17:24:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tQqY1CwgN+8vh4JthS9SGMZiqdF3o8jfKFTzXoe98bptMHBms3kWqMNPE3g977m+2dRcUn59K1xXb+pkcwApwF+RvwZNtjmAJc0npXCFLnEOaHNXu4UPOrqTLrJHsoRzSisYJ8LdjkMrIugwtX2iThNjQbVMYZjIproGOHASwSHp7M1ohSCgDSl2foXSURKFRqHpc85F6ENlVUUroAlUAE8+P0EqcbnU+szcO6JJWyLmAcDzjG14wdBXA0FYkKcvzMIrrZx5BJoSpNcYHcRIXAyX9REjlheBE6YlZWTDDcx9uJrJbbf7bHkOsjzHMH5MRI4750UkFeTT5L4XzV+Rgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/hf5/IW/VTsUH+jb7nM+VflxzDL0g/VgQKHKYwNsMIU=;
 b=ifr5FeGXfsxgtPUj/w67v50NquD7IOyRdJjDZhaR533tplZr9ifU1ranuEUKqiziPe/oscaOFaJ8Ng8Yuxcy0Ph811PbwMMMm4ihHYMXbDflZikgMAGOt/UHuEX7cYeBoKL9EsI9osS9aou9mGYF7rNkfyi9pALyQnUjaOE1EoQ2jhTuehWte8oGIaioxLA2p8BdhAHNzzuEVtZXuKl7XmJfiZliwBIDN5qkmD5mGZObOjdgoNm9988AlXbvLvzw9xF/IXixmKRtqEnkK4J5U4QoTm5jwV0xPd+r6zZX7y2k8OzSBfNlT35S2O/djBCQF1k6V0HI10RFbQyUDkyacA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/hf5/IW/VTsUH+jb7nM+VflxzDL0g/VgQKHKYwNsMIU=;
 b=K2QJABywrIgDkwaLFvqAFaLzlgIsZheb1hl8t7EjAoHA3HEapeQkDJnCgvGYhJtvaAUBqzndpDFCJ4FyC0bEu7PjHicz3XpIXycw1jI2TfHI+HVN28nzAyqudg5oG/MC6TAlioKRp+cbe7heP7pO9JM0UlB+PQbXGzq3SR28Lbs=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by BN0PR10MB4918.namprd10.prod.outlook.com (2603:10b6:408:12e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Wed, 31 Jul
 2024 17:24:09 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%7]) with mapi id 15.20.7807.030; Wed, 31 Jul 2024
 17:24:09 +0000
Message-ID: <f54ddf95-a5ab-4c56-966f-9bff37f50364@oracle.com>
Date: Wed, 31 Jul 2024 18:23:50 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 1/4] selftests/bpf: convert
 get_current_cgroup_id_user to test_progs
To: =?UTF-8?Q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?=
 <alexis.lothore@bootlin.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>
Cc: ebpf@linuxfoundation.org, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org
References: <20240731-convert_cgroup_tests-v1-0-14cbc51b6947@bootlin.com>
 <20240731-convert_cgroup_tests-v1-1-14cbc51b6947@bootlin.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20240731-convert_cgroup_tests-v1-1-14cbc51b6947@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SGXP274CA0012.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::24)
 To BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|BN0PR10MB4918:EE_
X-MS-Office365-Filtering-Correlation-Id: 731db6c8-2a64-4f4b-1bcf-08dcb18596ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U2pyai8zRm1BREJBT3F6VGFGL0dWc1ltS2ovdmV6dFE1T3pRZWlYekt6MUdl?=
 =?utf-8?B?ck0rY3VIWmxUUlg0MnlMN2tqWnN4M01JMXJkSkg2UzN4bjJtOUxaZDBMaWZQ?=
 =?utf-8?B?bk5MKzVQTndOMkM5dElDa3ExYkxNTHJZd2xCeFFkcGdkSm8yNXBMZCtWNjE3?=
 =?utf-8?B?NjZGdDF5dzhxRE81YkovNm92bzRMT2hweVVYVTlJNk1PV1lnWUQvcGdjenBp?=
 =?utf-8?B?SmpRNVJ4Zmxqb1RvWlhSVHVSb2t2WUpEeGJhT0hPSUwwRWptRHY0TGRCaWRJ?=
 =?utf-8?B?ZmRTb0tTT1Z4aXBnZEorOGdUM0ZySUVGZGl6QXlBVytKWjNMVzd5bElIMzdi?=
 =?utf-8?B?QUF1dlpud0JEQzhWRlE3T24xaWhSb0lyOUF1WmdyZ2trWVYyQmNwbkxqZlhi?=
 =?utf-8?B?cFFJVjNRQ3duejJYclRvamgyMnNoWWdLcVVVS1V5b1RyN2lqL1NpRGZVY1RC?=
 =?utf-8?B?ZW1RWTUvaHgrOWFzdXAyNU55UGUyV1d6cFhBVzFoRDhhTHI0MGdSTTJ2U2ox?=
 =?utf-8?B?RjVSdS9rd3cyaERTRC9YYi9Gcmd4dHhIOEZwU1NTMGl6eXA5cGNFRmh3OCsr?=
 =?utf-8?B?OWFZOGExb3Q1RHRSWDBUNnlsand5UzZtQ2prMzhjTFBNTWk3S1ErVmE4aGxF?=
 =?utf-8?B?MGtvWWx3bDN1VDhGT20rTlRxYjZpWGl0YkF5elFBckl2cWNLYlVGWURtMTBK?=
 =?utf-8?B?RXpXOUExdllWM3E1d01URmtVdkhBNyt0ZldwRjRmS2lreDcxdU92OGNCcGsr?=
 =?utf-8?B?a0dpRTMreXdsdXRRS0dEY2dGcCtFNDJ5bHZCRndqMVVzaCsxV2FPNFdvS2p5?=
 =?utf-8?B?elJOcEVmZnMzQk5HZGd6MThEZXNpZEozdG5tTzIyS1BMdEY3RmMxUEhNZmcy?=
 =?utf-8?B?a2t6Smw1dlQwU3J3NGkwZGJQSERyaStEQmZVY0JnREZsMEJhUk00RDRSYmhH?=
 =?utf-8?B?MGZvN3ZKcjM4RFZ2dTAydXB0QlJpYXREdGh1dzBSb2hvMHF0VHUyeUxnamVx?=
 =?utf-8?B?eUdCdGJSQmcrNUtJc3ZjRDV6SVNsc242LzBuVDRoa0dMMzZkcldGcWhXWDhY?=
 =?utf-8?B?TjNWMjhSYk1jODcwd0dUc0dvdFF3OGQvYkNrSEZObFVCZmc2cFE5SlZkakxR?=
 =?utf-8?B?TXh5b1RDU0gvRnBqTm80T01NYWVzSy9pUG03UmwwUWU3TTZhdExUZEdOb1dx?=
 =?utf-8?B?Y3pyWmhhNVQ5KzhvYWdGWkJGbXFzWjV3S0hJaDNUUXVTVlBhc05jMHM1S1Z1?=
 =?utf-8?B?NmlZN2w4UUNqMlJrVnNSQjRKaTJKb0xFaWMwSUFiSmsrekMyZEFBRURpTWxm?=
 =?utf-8?B?MFRvRC9yWVZSMVZqRzBqODdWS29qQXpxck12V015aE51ZmpqT0FrNVRVWUZj?=
 =?utf-8?B?ZU1uNWFjeHlabmNHL2VrLzYwVHVQMHJKTW9nZmxTdm93MjRCNGs4WUxzSlkw?=
 =?utf-8?B?VGtyS0R0ZGEzVVR1MXk2QkRTN2x3dEhnclVCYU9ubHNhWUJQTFE0RHRzbUVr?=
 =?utf-8?B?NmhaM21xemhFK0sxYTJHZFR3bFc2WVV6c1hPVEFqYUs4emYzN1lLaTZlK1NM?=
 =?utf-8?B?aE9HQjFlOHZKc1VhOXV5eWM2VUkrNDAyRWxOa2pONEl5bVJ6WndXNnV1SGxQ?=
 =?utf-8?B?akdBcnlHbjZWbUt1TEhveEVpcm5CNm5IMStvbTM3SjRkWWlkN1RJbjM3YjFE?=
 =?utf-8?B?TzlkZ0NJZ0tSZ0tibFJ1b1V1UzF6STR3cTdWNm92aTZITktLa3pUVUpaK3Vs?=
 =?utf-8?B?SFd4eFFFa1VxT1lod0hDSlg4aVRHU05xN1U5SGNsVWV0QnpnL1krUUpVNFhD?=
 =?utf-8?B?N25sMVpaVmZNUGpDbGt5RzI1QVU4cWE1V0hrdWtGQkxUYllWbG5mSG04TWZU?=
 =?utf-8?Q?7UEQVVt6OV+Nx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cWxBUnNjV3pkNE5hWTZLRjAxcjVGK0lQMDQvQkV0dTRURlQvWS9ZaDRSTlJL?=
 =?utf-8?B?bjJiU3NNMU1TVnlla1poaDB2eGJrWkhOWGZET21NL001eHByem5oUUIvS0da?=
 =?utf-8?B?Mk52K1pxMGVzZlkxS3JxWWZQck5vZXZmcE9CbHQ5VWs5WFlzeDZXSTNvcGo3?=
 =?utf-8?B?ei9QV1BqM3RMVXo4bEpveEszQWpzbEFTM0lWSFRNUlZKbWpXWWFXM2Z6STFX?=
 =?utf-8?B?M3ROYXFkb2R5QXhFVkFTZkttY2NDTURFakVJR0ZDYTVYejNiWEFCdFc4Ylo4?=
 =?utf-8?B?RWtlUEIzbzZFWnRUM2M2Q0hob2ZFdVpFSWZqUkFiZS9WMjZLclpjTkM4R04v?=
 =?utf-8?B?cjZJWlFXRFdyYkJrRE5rdVNXTnJITnJBbVQwUnhKUVRmZ1RCc3JoTm4wRVc0?=
 =?utf-8?B?Mm5YaENVWVB1VE5EWXhZUmFQeHhOTW9XdlVLQzlQWVhjdFZMa0x5VW8rdlB6?=
 =?utf-8?B?bkdNV1Btai9zTEh6STMrTk5YZ0FYZms2SDdyRTVYUnlZZllxeVJuS1dUQ2tr?=
 =?utf-8?B?UElZY0VDb05xZ0l6a1FiaUo1Mlo5RXB6ek5LbGFOVHE5Q3NLYVhmUUxRcU1P?=
 =?utf-8?B?ODV4aU44MHBWQytEcytwa0lQSzhvTGxSOXFzZHhBNUZURFhsdS9YcE5kb0hZ?=
 =?utf-8?B?VTQ1NEYwV2ZrR2NYVjhIVDF1UkdIK0hWaW9sbGVOam1pb2EzK1pOZVpqdS9i?=
 =?utf-8?B?ZkwyclZXeXVMTjYyVXRlaU5GNTNvTmFTSjlSNHBhaHppd0p5K0phaGVEUmhm?=
 =?utf-8?B?ZEpSbEc0WnFCZnl0TFNkYnRPZHFHb0lNYUJHdHAvMi90ak1zakNwWjY2Wk96?=
 =?utf-8?B?cm1MZ3RWUy9USnBkN2VYVnNCYXUxQ2VHaU1zb0MwQ2FFU21tT0FFNXNFSVEv?=
 =?utf-8?B?WXpHczc0dDFjTnNINm9vejR1eW9meDE1Ui84V0VGY0cwN1V1VWZhU0oxcGNi?=
 =?utf-8?B?WlkzTXZhc3lmNlV2bHR1OGd3REx3elF4amFyQlVXSlFCbkRWQlByajhyc2Vt?=
 =?utf-8?B?NXBBaEFGcDdVRmo4OUhSN3RKTVJnMG9IWS9kaUFiTGtZdzJIRjJubWVza3F4?=
 =?utf-8?B?ODIycUZ3RmxzMnE2TGlXTmFESXBsTXhnQUtMaldqQmRlRVVrckttTWRiNEN3?=
 =?utf-8?B?NGpEQTd1NGJMcGFkdW1WTGErNm1aUUlsdDZ5cDRORFFrK01MdVovQnB6S2p1?=
 =?utf-8?B?TlRNWUlCaXBXVjdNRVlIOHF2aXpSVVlWSUpGVzkvaXl0NzVyeUZKelBMRUor?=
 =?utf-8?B?MWZQZ3pwUmhOYSt6c1JzMk10VGhiYitYSHU3Zjl2WW05Q1pXMldVcGNGVDYw?=
 =?utf-8?B?OTRtRmkzd0FLZHlVcUxUcXRLZ1l6eVAwb3FiVlVmeXpncER1a2trU3QxUFQ4?=
 =?utf-8?B?cHBzWnFETXBSc3FJUk53bHJrY1dZcWpMaWgyY1hTMmJhWVhjV2FZWXU4TlVq?=
 =?utf-8?B?dE9zb3RCSFZycjB4RmQ3djB2MGZseVlmai9GcStQV2tVNVp6eElPWDdpeWFY?=
 =?utf-8?B?ZnRhSFV4ZUwrdCtzdy9TQUp5UDNvMU5lWVBVbmp6ZitrSmJCaDZWK3l0aHNk?=
 =?utf-8?B?eVdjVUE1aG5TK3UvQjEwYVg4VksxcWh1bFRnK1VFdDZFSGJKNUcvR2c4M2xt?=
 =?utf-8?B?MkNaeHVDTGlVWVVYeGpSbGRYQ0JzZ0tQUFJLVDJsaEhTRUVtcFdxL1g1dlRu?=
 =?utf-8?B?L1E5eTVXSjFFNjllS3FWUTF4WXluQUo5dVlGb3E0cXM2Ry93b3NrbzIzZ0xs?=
 =?utf-8?B?NDVCSEJ1OTVxUUx2YTJrVkVyYWxKRHlzRGxYZ0hRRGdzZGExYjZleFVZTEg1?=
 =?utf-8?B?cUZFZHVxVWRwZm0rTXovcUxaTm5uNWdVUUF0eVprUi85RVlwMG1jVWN4ZE4x?=
 =?utf-8?B?bWpZOWRjL0FvQUUzY2U0TW1KbS9LZm54TGV2SGZBUmc5Sk92dUIvYjY5dldD?=
 =?utf-8?B?RUl4bUhKQkdZelJkU1JNeVI4SXIxWXRxSnVuNTdPcnY1c1IzZnNxOHRsTmw3?=
 =?utf-8?B?eDFVYWVjcVZ2WmpZd09IemUrb1RZN3l5eWRudzBQaS9MdnhyL1l2eDlYNm9y?=
 =?utf-8?B?N3Rwa3lKSTN2UDlJWGR5M25JT21XdmxoVFRTblY5dTJwa2VNR2RtQ1dvSlhY?=
 =?utf-8?B?cVJkRElnQS9ZVWtSNjZvMld1ZldxT0x4RllPMXFtVkRQS2JmbHlFa1ZFNHpl?=
 =?utf-8?Q?K0m3df8F9r47RK4h482XoZE=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	agxWhGaymiuh9U1pwu2cTPwZzcYZriBOmkc/+ZWq4UCyv71cRGiQpdY8bYerNLKVt5aPq7QqEhBOi6/8q0FrUev62xmy4FOdwcuJ5NSRjvxSCKZNg61+0JdOPt4KG1eiOAuMlltENHHBn59iv87XT6zLP9xcbF6WAl1dmT3wdzJP2PGeao1AuIWYNstzuAbMAL4YVLrVwt7k0vbDb5pTzzaPpKs/95oCx+xY2K9WTsoTENMGh/TTfztbQdajE2sd9h8CXmKCLvIvg2cW2+lHE17duMc1CewFirNZA394kjoiAPm8QMezL+2kiJrTljm5BODT30gGD+TyQvwDdXaaUJB1e5YO9PEFWAxeeRAOsOAUHKfg75L/lObYVL6EiXQjoSS3a6j66eXWVqU+Mi41GUMTGZ04u5cOfwQcj0zz6MqiNBu6ABW/+vFEbYnQauasph+CbkxY/bvB7m8YIX50TejDieDkJ3trcdx20nzjTjOSaCewZV2+N1UG/MwX62sC8wyLDUQIbGiPSrw9UYK1TBKbv7JYwp3YcS8FeHEEGdS7/yDKRDnor+fqHUHY70kEAgaKZG8nyuaJILWmWwFdulafpBdLl5M4ukstDuXAcjk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 731db6c8-2a64-4f4b-1bcf-08dcb18596ba
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 17:24:09.8791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gKkMXEBz/wh9qSwWMevPJlxaFZKGB6sJ3oO/HSmlVlZLyQ/26/ULLYY5IuQtjzLCLe6CgJnC+NEDdCf5FxntOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4918
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-31_10,2024-07-31_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 suspectscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407310121
X-Proofpoint-ORIG-GUID: Q5TtQ562BUF2IBxSW3u8xyNXnt9P4fT4
X-Proofpoint-GUID: Q5TtQ562BUF2IBxSW3u8xyNXnt9P4fT4

On 31/07/2024 11:38, Alexis Lothoré (eBPF Foundation) wrote:
> get_current_cgroup_id_user allows testing for bpf_get_current_cgroup_id()
> bpf API but is not integrated into test_progs, and so is not tested
> automatically in CI.
> 
> Convert it to the test_progs framework to allow running it automatically.
> The most notable differences with the old test are the following:
> - the new test relies on autoattach instead of manually hooking/enabling
>   the targeted tracepoint through perf_event, which reduces quite a lot the
>   test code size
> - sleep duration passed to nanosleep syscall has been reduced to its
>   minimum to not impact overall CI duration (we only care about the syscall
>   being properly triggered, not about the passed duration)
> 
> Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>

Nice work! Two small suggestions below..

> ---
> The new test_progs part has been tested in a local qemu environment:
> 
>   ./test_progs -a cgroup_get_current_cgroup_id
>   47      cgroup_get_current_cgroup_id:OK
>   Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED
> ---
>  tools/testing/selftests/bpf/.gitignore             |   1 -
>  tools/testing/selftests/bpf/Makefile               |   3 +-
>  tools/testing/selftests/bpf/get_cgroup_id_user.c   | 151 ---------------------
>  .../bpf/prog_tests/cgroup_get_current_cgroup_id.c  |  58 ++++++++
>  4 files changed, 59 insertions(+), 154 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/.gitignore b/tools/testing/selftests/bpf/.gitignore
> index 4e4aae8aa7ec..108eb10626b9 100644
> --- a/tools/testing/selftests/bpf/.gitignore
> +++ b/tools/testing/selftests/bpf/.gitignore
> @@ -20,7 +20,6 @@ test_sock
>  urandom_read
>  test_sockmap
>  test_lirc_mode2_user
> -get_cgroup_id_user
>  test_skb_cgroup_id_user
>  test_cgroup_storage
>  test_flow_dissector
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index 1d7a62e7deff..8d8483f81009 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -68,7 +68,7 @@ endif
>  # Order correspond to 'make run_tests' order
>  TEST_GEN_PROGS = test_verifier test_tag test_maps test_lru_map test_lpm_map test_progs \
>  	test_dev_cgroup \
> -	test_sock test_sockmap get_cgroup_id_user \
> +	test_sock test_sockmap \
>  	test_cgroup_storage \
>  	test_tcpnotify_user test_sysctl \
>  	test_progs-no_alu32
> @@ -297,7 +297,6 @@ $(OUTPUT)/test_skb_cgroup_id_user: $(CGROUP_HELPERS) $(TESTING_HELPERS)
>  $(OUTPUT)/test_sock: $(CGROUP_HELPERS) $(TESTING_HELPERS)
>  $(OUTPUT)/test_sockmap: $(CGROUP_HELPERS) $(TESTING_HELPERS)
>  $(OUTPUT)/test_tcpnotify_user: $(CGROUP_HELPERS) $(TESTING_HELPERS) $(TRACE_HELPERS)
> -$(OUTPUT)/get_cgroup_id_user: $(CGROUP_HELPERS) $(TESTING_HELPERS)
>  $(OUTPUT)/test_cgroup_storage: $(CGROUP_HELPERS) $(TESTING_HELPERS)
>  $(OUTPUT)/test_sock_fields: $(CGROUP_HELPERS) $(TESTING_HELPERS)
>  $(OUTPUT)/test_sysctl: $(CGROUP_HELPERS) $(TESTING_HELPERS)
> diff --git a/tools/testing/selftests/bpf/get_cgroup_id_user.c b/tools/testing/selftests/bpf/get_cgroup_id_user.c
> deleted file mode 100644
> index aefd83ebdcd7..000000000000
> --- a/tools/testing/selftests/bpf/get_cgroup_id_user.c
> +++ /dev/null
> @@ -1,151 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -// Copyright (c) 2018 Facebook
> -
> -#include <stdio.h>
> -#include <stdlib.h>
> -#include <string.h>
> -#include <errno.h>
> -#include <fcntl.h>
> -#include <syscall.h>
> -#include <unistd.h>
> -#include <linux/perf_event.h>
> -#include <sys/ioctl.h>
> -#include <sys/time.h>
> -#include <sys/types.h>
> -#include <sys/stat.h>
> -
> -#include <linux/bpf.h>
> -#include <bpf/bpf.h>
> -#include <bpf/libbpf.h>
> -
> -#include "cgroup_helpers.h"
> -#include "testing_helpers.h"
> -
> -#define CHECK(condition, tag, format...) ({		\
> -	int __ret = !!(condition);			\
> -	if (__ret) {					\
> -		printf("%s:FAIL:%s ", __func__, tag);	\
> -		printf(format);				\
> -	} else {					\
> -		printf("%s:PASS:%s\n", __func__, tag);	\
> -	}						\
> -	__ret;						\
> -})
> -
> -static int bpf_find_map(const char *test, struct bpf_object *obj,
> -			const char *name)
> -{
> -	struct bpf_map *map;
> -
> -	map = bpf_object__find_map_by_name(obj, name);
> -	if (!map)
> -		return -1;
> -	return bpf_map__fd(map);
> -}
> -
> -#define TEST_CGROUP "/test-bpf-get-cgroup-id/"
> -
> -int main(int argc, char **argv)
> -{
> -	const char *probe_name = "syscalls/sys_enter_nanosleep";
> -	const char *file = "get_cgroup_id_kern.bpf.o";
> -	int err, bytes, efd, prog_fd, pmu_fd;
> -	int cgroup_fd, cgidmap_fd, pidmap_fd;
> -	struct perf_event_attr attr = {};
> -	struct bpf_object *obj;
> -	__u64 kcgid = 0, ucgid;
> -	__u32 key = 0, pid;
> -	int exit_code = 1;
> -	char buf[256];
> -	const struct timespec req = {
> -		.tv_sec = 1,
> -		.tv_nsec = 0,
> -	};
> -
> -	cgroup_fd = cgroup_setup_and_join(TEST_CGROUP);
> -	if (CHECK(cgroup_fd < 0, "cgroup_setup_and_join", "err %d errno %d\n", cgroup_fd, errno))
> -		return 1;
> -
> -	/* Use libbpf 1.0 API mode */
> -	libbpf_set_strict_mode(LIBBPF_STRICT_ALL);
> -
> -	err = bpf_prog_test_load(file, BPF_PROG_TYPE_TRACEPOINT, &obj, &prog_fd);
> -	if (CHECK(err, "bpf_prog_test_load", "err %d errno %d\n", err, errno))
> -		goto cleanup_cgroup_env;
> -
> -	cgidmap_fd = bpf_find_map(__func__, obj, "cg_ids");
> -	if (CHECK(cgidmap_fd < 0, "bpf_find_map", "err %d errno %d\n",
> -		  cgidmap_fd, errno))
> -		goto close_prog;
> -
> -	pidmap_fd = bpf_find_map(__func__, obj, "pidmap");
> -	if (CHECK(pidmap_fd < 0, "bpf_find_map", "err %d errno %d\n",
> -		  pidmap_fd, errno))
> -		goto close_prog;
> -
> -	pid = getpid();
> -	bpf_map_update_elem(pidmap_fd, &key, &pid, 0);
> -
> -	if (access("/sys/kernel/tracing/trace", F_OK) == 0) {
> -		snprintf(buf, sizeof(buf),
> -			 "/sys/kernel/tracing/events/%s/id", probe_name);
> -	} else {
> -		snprintf(buf, sizeof(buf),
> -			 "/sys/kernel/debug/tracing/events/%s/id", probe_name);
> -	}
> -	efd = open(buf, O_RDONLY, 0);
> -	if (CHECK(efd < 0, "open", "err %d errno %d\n", efd, errno))
> -		goto close_prog;
> -	bytes = read(efd, buf, sizeof(buf));
> -	close(efd);
> -	if (CHECK(bytes <= 0 || bytes >= sizeof(buf), "read",
> -		  "bytes %d errno %d\n", bytes, errno))
> -		goto close_prog;
> -
> -	attr.config = strtol(buf, NULL, 0);
> -	attr.type = PERF_TYPE_TRACEPOINT;
> -	attr.sample_type = PERF_SAMPLE_RAW;
> -	attr.sample_period = 1;
> -	attr.wakeup_events = 1;
> -
> -	/* attach to this pid so the all bpf invocations will be in the
> -	 * cgroup associated with this pid.
> -	 */
> -	pmu_fd = syscall(__NR_perf_event_open, &attr, getpid(), -1, -1, 0);
> -	if (CHECK(pmu_fd < 0, "perf_event_open", "err %d errno %d\n", pmu_fd,
> -		  errno))
> -		goto close_prog;
> -
> -	err = ioctl(pmu_fd, PERF_EVENT_IOC_ENABLE, 0);
> -	if (CHECK(err, "perf_event_ioc_enable", "err %d errno %d\n", err,
> -		  errno))
> -		goto close_pmu;
> -
> -	err = ioctl(pmu_fd, PERF_EVENT_IOC_SET_BPF, prog_fd);
> -	if (CHECK(err, "perf_event_ioc_set_bpf", "err %d errno %d\n", err,
> -		  errno))
> -		goto close_pmu;
> -
> -	/* trigger some syscalls */
> -	syscall(__NR_nanosleep, &req, NULL);
> -
> -	err = bpf_map_lookup_elem(cgidmap_fd, &key, &kcgid);
> -	if (CHECK(err, "bpf_map_lookup_elem", "err %d errno %d\n", err, errno))
> -		goto close_pmu;
> -
> -	ucgid = get_cgroup_id(TEST_CGROUP);
> -	if (CHECK(kcgid != ucgid, "compare_cgroup_id",
> -		  "kern cgid %llx user cgid %llx", kcgid, ucgid))
> -		goto close_pmu;
> -
> -	exit_code = 0;
> -	printf("%s:PASS\n", argv[0]);
> -
> -close_pmu:
> -	close(pmu_fd);
> -close_prog:
> -	bpf_object__close(obj);
> -cleanup_cgroup_env:
> -	cleanup_cgroup_environment();
> -	return exit_code;
> -}
> diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_get_current_cgroup_id.c b/tools/testing/selftests/bpf/prog_tests/cgroup_get_current_cgroup_id.c
> new file mode 100644
> index 000000000000..dd8835a63a00
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/cgroup_get_current_cgroup_id.c
> @@ -0,0 +1,58 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <sys/stat.h>
> +#include <sys/sysmacros.h>
> +#include "test_progs.h"
> +#include "cgroup_helpers.h"
> +#include "get_cgroup_id_kern.skel.h"
> +
> +#define TEST_CGROUP "/test-bpf-get-cgroup-id/"
> +
> +void test_cgroup_get_current_cgroup_id(void)
> +{
> +	struct get_cgroup_id_kern *skel;
> +	const struct timespec req = {
> +		.tv_sec = 0,
> +		.tv_nsec = 1,
> +	};
> +	__u64 kcgid, ucgid;
> +	int cgroup_fd;
> +	int key = 0;
> +	int pid;
> +
> +	cgroup_fd = cgroup_setup_and_join(TEST_CGROUP);
> +	if (!ASSERT_OK_FD(cgroup_fd, "cgroup switch"))
> +		return;
> +
> +	skel = get_cgroup_id_kern__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "load program"))
> +		goto cleanup_cgroup;
> +
> +	if (!ASSERT_OK(get_cgroup_id_kern__attach(skel), "attach bpf program"))
> +		goto cleanup_progs;
> +
> +	pid = getpid();
> +	if (!ASSERT_OK(bpf_map__update_elem(skel->maps.pidmap, &key,
> +					    sizeof(key), &pid, sizeof(pid), 0),
> +		       "write pid"))
> +		goto cleanup_progs;
> +

I think it would be worth using a global variable in the BPF program
my_pid, and setting skel->bss->my_pid here as other more up-to-date
tests do (example progs/test_usdt.c, prog_tests/usdt.c). No need for a
separate map anymore.

> +	/* trigger the syscall on which is attached the tested prog */
> +	if (!ASSERT_OK(syscall(__NR_nanosleep, &req, NULL), "nanosleep"))
> +		goto cleanup_progs;
> +
> +	if (!ASSERT_OK(bpf_map__lookup_elem(skel->maps.cg_ids, &key,
> +					    sizeof(key), &kcgid, sizeof(kcgid),
> +					    0),
> +		       "read bpf cgroup id"))
> +		goto cleanup_progs;
> +

ditto here, cg_ids could be a global var cg_id that the bpf prog sets
and we check here via skel->bss->cg_id.

> +	ucgid = get_cgroup_id(TEST_CGROUP);
> +
> +	ASSERT_EQ(kcgid, ucgid, "compare cgroup ids");
> +
> +cleanup_progs:
> +	get_cgroup_id_kern__destroy(skel);
> +cleanup_cgroup:
> +	cleanup_cgroup_environment();
> +}
>

