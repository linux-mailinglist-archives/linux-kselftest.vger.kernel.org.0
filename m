Return-Path: <linux-kselftest+bounces-31765-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA903A9F063
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 14:12:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1191A460A8F
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 12:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4027D268FCE;
	Mon, 28 Apr 2025 12:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OIKWOIuz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2044.outbound.protection.outlook.com [40.107.93.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C3B268C7A;
	Mon, 28 Apr 2025 12:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745842364; cv=fail; b=onKMYZatb7AMS3BneGcpEXw3RGg3BuhkLi4fNg3FTgqZF8ee46gFOQHbNqAd/G6KVV/nlVzVwrhTx5e265QCncQ3hde3sbtwOaX/QXVafbNcO2qZJdtjST4u6GsKVwjoR2qfVcr07qM3CVrxjKJphXXWY1kcjh+a5mSxHdldq8I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745842364; c=relaxed/simple;
	bh=SDZrMg2+Zzs4v/JSyBFupvYkh9B6YZZIaYh8L5Uj/Yw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=N/0atNaEA6caDiK32DEgZkKjkLHPQba66/rj4UCSh6GOHgC0g67gpVLmeFynQmVzKDLpgjNCcoaqMTPctA8jaYHuAbP+Tro7QqX8bg08VT5CJD5K7+/vbLgNXPibKALcZdbkpGPkL/sBNwIZ8CViwnSaTN10/F7YYahLAXTTXGQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OIKWOIuz; arc=fail smtp.client-ip=40.107.93.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PLkOKVWxJ4m9hRqFTkrNnPv4aTBr5HB9f6cQTHY1alPADkPQkiH9VFQJBF87aNKQqeqrLmiZ35SjWM7LuqoqGZnbafE4P666bhiXQyeuPYY18FJVTNW0tHeuEf0VfvLSd11RrdxtgDKAEyhafRtqiCs0BCiOD2gbhuYrVi6EIObDddJNOAHbchg9H1itFGx2t+It1WtaTSyTocHCgsPNTo7YaMP+0FgGfDHMkCRX3P2PV2MikbyzviNUQffPwbJtLWvvbaVNHuz0VHYUu/zi5PKkgBHjAuj6lycIRm2QG9L5murxESjXKxwBoRxlLWtcniygc7ayXaRHt0ScElbKew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W8FxBiBWlsg5dr9TwENqn0JVNX4lwt4dgrfPOeDZLZM=;
 b=kVtMo1EwVC+UyuY57OcvtDuUQENU14TpgEvrDFUO3MbTmcIC0siuCUu1U+w2R7fdUjQydvvZeIFL2GPoVtEM6v6ktNxqxswbG0reMfADxMRYpoAl2HSxhsASyldJXXmfW082fPBQGoZQBJjTn3d36UF0EK+53S6ECO+ykeS1kDR7mDffgkGi/dZmm3HbW/du4sFVeKwTTIsN/YOogEJXymMwi3B1Lg/yGvUZmTEKByyx1qLp6lVSRhGn+rBRJgTVwOkhDNiA+1LGXqRsCvJQb2doI/EDjqbyPIz5sgvCEMRlACq1EyGxhAu2XjoU3ykOj49W73MFcLUV2rpgF5TSwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W8FxBiBWlsg5dr9TwENqn0JVNX4lwt4dgrfPOeDZLZM=;
 b=OIKWOIuzg+Si/nQ3EwF5lvaY2OxWEDu7APOGituI5+lve9ak7l20+WWgT/ldQW6Pm52HKBuh+hsPCFd2WoG4GnmvKrhaEJ9vHfC+e5fwNBzw+s+js9zWkK7uFHXQiOTPwUGuOftpx4i3iE4pMj+9YClOWL9n51OAENBEXevKkZ8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 PH7PR12MB5593.namprd12.prod.outlook.com (2603:10b6:510:133::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8678.31; Mon, 28 Apr 2025 12:12:39 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%5]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 12:12:39 +0000
Message-ID: <b0d01609-bdda-49a3-af0c-ca828a9c4cea@amd.com>
Date: Mon, 28 Apr 2025 17:42:27 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/22] iommufd/viommmu: Add IOMMUFD_CMD_VCMDQ_ALLOC
 ioctl
To: Nicolin Chen <nicolinc@nvidia.com>, jgg@nvidia.com, kevin.tian@intel.com,
 corbet@lwn.net, will@kernel.org
Cc: bagasdotme@gmail.com, robin.murphy@arm.com, joro@8bytes.org,
 thierry.reding@gmail.com, vdumpa@nvidia.com, jonathanh@nvidia.com,
 shuah@kernel.org, jsnitsel@redhat.com, nathan@kernel.org,
 peterz@infradead.org, yi.l.liu@intel.com, mshavit@google.com,
 praan@google.com, zhangzekun11@huawei.com, iommu@lists.linux.dev,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
 linux-kselftest@vger.kernel.org, patches@lists.linux.dev, mochs@nvidia.com,
 alok.a.tiwari@oracle.com,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
References: <cover.1745646960.git.nicolinc@nvidia.com>
 <094992b874190ffdcf6012104b419c8649b5e4b4.1745646960.git.nicolinc@nvidia.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <094992b874190ffdcf6012104b419c8649b5e4b4.1745646960.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0109.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::22) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|PH7PR12MB5593:EE_
X-MS-Office365-Filtering-Correlation-Id: cd9c9f37-5814-46e3-8f12-08dd864df833
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZGNnRHY0M0Jkc1lWQnlmYi9jV0ZPZyt4RXM4eTFVQ0swU3VvaGhieE1JMVI5?=
 =?utf-8?B?OERVZHdtMEdYODBRajNZbHNDd3BTNFhnMjFiUERMU1dNQWsyUnF3RmFjMEE0?=
 =?utf-8?B?SDlKQTZPNFpMd2hzSW1hTk1oVmVxM09XamdOamZKempLOWJWdWlqZlZva203?=
 =?utf-8?B?Y3ZFc3pkdFp5WjEwcWl6WWdNby9HNGtnamNyN001bktSTGdsMjBYQitaMWpn?=
 =?utf-8?B?L0NZSXQ4aHJTWEkyZE1adyt5TENqQnhsK0VsdGNwYVB3MW03SVRoV2o1dGJy?=
 =?utf-8?B?elBWNnZEc3k2QWJZS3hGU2ZFbjhHajN2WmttbGM4OC8rV1NheVh0U0pDY2oy?=
 =?utf-8?B?QXRKRlQwOGxlb2ZSSERXRGl5T0I4ZHphOHB2ZWZRdXhBVHZxYWpSeXJadDlE?=
 =?utf-8?B?aEtjNGRHd1dEbStIVSs3NGJtOHlqcWVxclkvKzlEWURTdndRL3NsRzJ5YUFs?=
 =?utf-8?B?QnNxS1NKV25pK1V1Nk5STEdWaTF6TTRKVG92R3hlOS9HamYrQmhyL2NhbVhy?=
 =?utf-8?B?Q2xBTjQ1MlF0bWlMeVgwVFFSVXNpeExidnFpYUFUc2t6d01mUGhZZkppZFRr?=
 =?utf-8?B?cHNuNVJ4ZDBrbGJVRmhvZU5odG95dUExaVR0RjdTNzNucXFWN0tpdzJsMGRx?=
 =?utf-8?B?bFFuZzJ6aTJwK0E2eS9IeHlmZ2Q1d0h0L1ptUnN2aGlaeE5XbDYyWUp5OUZw?=
 =?utf-8?B?WXhKVlYyQmRsZlUxSmY1Y2pkbnNidWdqeFVXNGQ5NGcvREU4T0RFWStoYllj?=
 =?utf-8?B?TzRMLzliajZ0QldjVW94YTZjT1FvQnZuSEtMb3lkb3h5eWRvQllyYWNIa3ZG?=
 =?utf-8?B?WVpQdU01VzlCdmpmcmlwcnNGbGVPV0RUREdQaFA0SCtHWUt4ZlpwcjJkWnFh?=
 =?utf-8?B?RTVLc09TYXFOT25kUmUrby9kaHplWlQzbXpVcEdWU1AvTjBBQ1lOZkR2YXRh?=
 =?utf-8?B?c2VQTmNOUEsvSS9xUnZOelRweWJWODZ4cmNadWljT0YvSzF0NUVwOUxTTnRl?=
 =?utf-8?B?SEZEK1BCelhSVkZEMkZuSEozVDE4RmwxV2JBb2loSmVXekdBM1NRblRSQTRL?=
 =?utf-8?B?dENGL01rcENNZjYwVHFQcFljWGRrb3o3VDBEUVpFWUlReGV1QmwzQ0U4S1Vw?=
 =?utf-8?B?MGRWR1d2RVBqTkJhcGhDNnVqV29XUUdYVkJMOWVxR295ZkI4bUU1YzJaTHVl?=
 =?utf-8?B?eGxSZ1o0RjVtM05RdUthdFE3SWtLcWxlZng2NVBFS2hWQ2F6dEZRcTFEcnNs?=
 =?utf-8?B?dWF2anFJbnZkb1ptemtTVURFY2VWUk9mOUExNlRIQTQ0ZTdtTjFUUzFjTXFx?=
 =?utf-8?B?SUVlTVRXRlZ6Qmk5dDVxREZ6ZDNCVHkrbC9lS1R6K29ydGtiNXdQbU9FTFVL?=
 =?utf-8?B?QThnSWxjeXhtL3JaR1J2MHZJTjNoQXRJem4zMjNaVENKTUFBWVpKZDBmcDBt?=
 =?utf-8?B?elB5Sy9RNlhZVHE2elIwRUV5TWRCSjFyc3VpbWhIdDAvZ243L1paUGtYMkd2?=
 =?utf-8?B?WmlWUmpHNkRRMmlzcm9scHA2aitYdFA4TnhnUmo4V0V5YUJOU0dqLy9WZ1k1?=
 =?utf-8?B?ZUYydDR0T1BLVFRrR3FVc0oySHUxNTBWL2RyYnZZbnpLQnMyVG04WG1UY2pK?=
 =?utf-8?B?Sys3aEdkM0pXNXpkU0UvSDZHRm1JNnZadUtPRFVJempjMENzNGZsQjBzZXVq?=
 =?utf-8?B?UlRnSnR0N0lDRWVSUmVldDZud2c2RXBnWWw4YW1jT3VSdHUwRGR3SUlkOEhJ?=
 =?utf-8?B?MnVsOFlGVHZnNGQvTUlWWnRyd29adGExQlFsclU1SnpoVU1oRUovN3l2ZUJv?=
 =?utf-8?B?aG80OHp2OXd1TEhkK2N4Z3E5Rk50S2x6MXova2ZFV1VyTDUxWlo5M1JlOGxj?=
 =?utf-8?B?TGZrTmYxQmt6SXFjdFM4TDFzU3dGdmRuQVhZQUxGejlkc05ZbUY0SCtETERw?=
 =?utf-8?Q?0z00/9vAJkQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UzV0N2JrOWt5cmVKei95c1ZRR1YvMWxCSUJzYm8zeHRMYWRGS2ZBTmx0Unlz?=
 =?utf-8?B?cUtGRnBuak94RkVhSkxNWitrNXF5eGl3eHY1amJlaVEvYzEzSnZTdXNjL0Fm?=
 =?utf-8?B?Vy9BSTdKN0V5UzBIWEhUWTVjcXo5VGFkRzBGUVdjNklza2UyYjI0K1MyUzQw?=
 =?utf-8?B?ZDd2b1A0UU5IclRVWE1DL0wxREo1a1QyZndabjJLL201RW1YbzRBbGJLM1BH?=
 =?utf-8?B?KytXSE5tLzBnRlRBUmMwTXlXZkwwQU91U1NMeUo4OUhaQ1YvYklYYUtjcWE0?=
 =?utf-8?B?QUdzKzFmaUJJUGdjOWlYUmphZFlOZERSUEJnUzNtcDBzMjZZVkI2VGhpUlll?=
 =?utf-8?B?UlQwUmZwN1p5cXBEQk1vd0U5SzBzcm8yZm0zYlMrZjZSVTVIUkxSekJ4WHVZ?=
 =?utf-8?B?aVRYYWhKeDBTejF0cU1aQjNocFJhelRKdWhVOGEvU3pvWXUyclpwVGI3SGFr?=
 =?utf-8?B?NkhjelpVd00vSm96SVdKdVlwSS93YnpCRGgwL3V0akx0SWxjTVZNY2ZoUFh3?=
 =?utf-8?B?VEtKYlNnNzcwUDVhVGNoSFZJV2wremk0SElzb2pTTllOMVYwU29mOWJkMEJI?=
 =?utf-8?B?MUVzelhLSXlKOE9NUldQV0xtdEM5RFVNZ2RaQTFHTUxyeUZURTUrZThoRTJW?=
 =?utf-8?B?RUhXaTBuQ29JMEZVZnpIUlloRDZ5Qk56UC8vOXROR1NYVVkxUThPZ2FVS3Qy?=
 =?utf-8?B?Q1lpZEVoYkRGWkU1VUVIR292cjBMN1A1UEhVQnk5S0FpQUJTSXA3cGZndmI1?=
 =?utf-8?B?eGVCU2lPTlFOVGVQUSs2eS9qcWZUbDNIY0ttNGJXVG9QZnF4blZXWmtwZ2hz?=
 =?utf-8?B?cWpHNktGYVBqWm42WFhvbGlYd0Z3OXFNVnVGUGdLd1VpOGJoQ1JILzRNYSto?=
 =?utf-8?B?YnpsUEJOQTQydzFSUEdDaUhQNzBDMkh4Y21aRGU2SWRsM0tiTkFLd0hoZEo2?=
 =?utf-8?B?cDB4ZDFMd08rZnIvcUIvSDJOQk9xc0hHc0cwYXRwdkYwemdpL3pKb2xzTEg1?=
 =?utf-8?B?aXRlZi9nTU5QYWxycU1uRFNjT3RVY0kwREVaaXV6eTVka1ZwNkdqQ2JLVGhZ?=
 =?utf-8?B?eWQ3TWsrTmV4aXppWGxGeWJTNC9MMWlYSzZlRTQ3MmpaYWlQbElNTDhRSURX?=
 =?utf-8?B?RDVLa1p1YitVU3FYS0F5NlBEV0NSSW5HTGxLQWNXV0RWelRpYjA1dzA5cS9I?=
 =?utf-8?B?WDU4ZTJ4R05Da3ROek82WDNISk9XR3VFZGZRQ2kzNG1QKzZEZ2h6allUVXdO?=
 =?utf-8?B?bEgzVXo4SWd0U2kvL3l6Y2lGWEgxWitBdVNPUlJGN2FkK1dzanNrMTViTFBN?=
 =?utf-8?B?VDNubGxCcHRibWtCOERNWlB5dHhlenFaSlFUU2VyVHdPRUY3STR4SlMwYzBU?=
 =?utf-8?B?SEVEU2F0Ty9yUDVFWnQxMndTUkxKaXRrZU94bFlxVmREQ3NZNmtURUs4Vzlx?=
 =?utf-8?B?Y2ZwWFM0d0ViclV4WUtQNWIrYXJUenRiUjN2Q2pGTy95MFZkT0NDWVRmTllw?=
 =?utf-8?B?SWRxVkcxQ0l2SUlNMlAvdXdyeUlEZ0RCZWIrL3V2b0R2RzI0NkZ0SnBSeFY4?=
 =?utf-8?B?R1Ntc2EzVDBOaFpWZU4wdS9NTzJ2UFJXbFc2dlIrMll2VGhSbWtsQ2JmVmRZ?=
 =?utf-8?B?VytQeXVjWmIzcTBpWlBOTk9IYnpCVjAyR2duSlJ6TlErZkJjdFlMYy9BSExx?=
 =?utf-8?B?NWRubUo1NDVuKzNCZ2ROOTlkSzNDd1g1R3V1eXpYdzJpMUxJSW1hUEhrMGRG?=
 =?utf-8?B?RUZnOWNleS9RaDdOME55a2orcnhET29TVzc1c0t4M20rRzBiQjVMcWZFRW44?=
 =?utf-8?B?VGl0bm5odllkTjkzTnd2bjljQmFJRFM4YWNvR0ZaQlVPNmZDN3lyMjdNMXAv?=
 =?utf-8?B?R0R0WDZwdUZnSS9reldPbzRvYnBVSEI1SGE1ZXNkdzIweCs0VGZ2Mm1MczRJ?=
 =?utf-8?B?dUs4QVVqSmNUcjlnL2ZaMUhoTlhEd1BEZkE0bkU2TlNvV0haYVJVWldmV1hE?=
 =?utf-8?B?cHM0aDNzZU44elNweVlsUFJ4OHViak1KczZmSFZuNVlBRFdzemNldnZpQko1?=
 =?utf-8?B?QzRuNWF1Z05mSzlwVjNZV1hHcDVxbU5CS2FoT2JEVDVxajAvRFBYTUVrVTRy?=
 =?utf-8?Q?Q4oy5Hbs6WROR2gYl8vajn4G1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd9c9f37-5814-46e3-8f12-08dd864df833
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 12:12:39.4749
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4WyvRbH41df2SCzln30de+mi9FJEGXla3WWcGLFgBh5ppLII1TO9HGCfEWIMVyYNSm+yyWf7N1tcjoc5wO1jrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5593

Hi Nicolin,


[+Suravee]

On 4/26/2025 11:28 AM, Nicolin Chen wrote:
> Introduce a new IOMMUFD_CMD_VCMDQ_ALLOC ioctl for user space to allocate
> a vCMDQ for a vIOMMU object. Simply increase the refcount of the vIOMMU.
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/iommufd/iommufd_private.h |  2 +
>  include/uapi/linux/iommufd.h            | 41 +++++++++++
>  drivers/iommu/iommufd/main.c            |  6 ++
>  drivers/iommu/iommufd/viommu.c          | 94 +++++++++++++++++++++++++
>  4 files changed, 143 insertions(+)
> 
> diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
> index 79160b039bc7..b974c207ae8a 100644
> --- a/drivers/iommu/iommufd/iommufd_private.h
> +++ b/drivers/iommu/iommufd/iommufd_private.h
> @@ -611,6 +611,8 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd);
>  void iommufd_viommu_destroy(struct iommufd_object *obj);
>  int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd);
>  void iommufd_vdevice_destroy(struct iommufd_object *obj);
> +int iommufd_vcmdq_alloc_ioctl(struct iommufd_ucmd *ucmd);
> +void iommufd_vcmdq_destroy(struct iommufd_object *obj);
>  
>  #ifdef CONFIG_IOMMUFD_TEST
>  int iommufd_test(struct iommufd_ucmd *ucmd);
> diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
> index cc90299a08d9..06a763fda47f 100644
> --- a/include/uapi/linux/iommufd.h
> +++ b/include/uapi/linux/iommufd.h
> @@ -56,6 +56,7 @@ enum {
>  	IOMMUFD_CMD_VDEVICE_ALLOC = 0x91,
>  	IOMMUFD_CMD_IOAS_CHANGE_PROCESS = 0x92,
>  	IOMMUFD_CMD_VEVENTQ_ALLOC = 0x93,
> +	IOMMUFD_CMD_VCMDQ_ALLOC = 0x94,
>  };
>  
>  /**
> @@ -1147,4 +1148,44 @@ struct iommu_veventq_alloc {
>  	__u32 __reserved;
>  };
>  #define IOMMU_VEVENTQ_ALLOC _IO(IOMMUFD_TYPE, IOMMUFD_CMD_VEVENTQ_ALLOC)
> +
> +/**
> + * enum iommu_vcmdq_type - Virtual Command Queue Type
> + * @IOMMU_VCMDQ_TYPE_DEFAULT: Reserved for future use
> + */
> +enum iommu_vcmdq_type {
> +	IOMMU_VCMDQ_TYPE_DEFAULT = 0,
> +};
> +
> +/**
> + * struct iommu_vcmdq_alloc - ioctl(IOMMU_VCMDQ_ALLOC)
> + * @size: sizeof(struct iommu_vcmdq_alloc)
> + * @flags: Must be 0
> + * @viommu_id: Virtual IOMMU ID to associate the virtual command queue with
> + * @type: One of enum iommu_vcmdq_type


> + * @index: The logical index to the virtual command queue per virtual IOMMU, for
> + *         a multi-queue model
> + * @out_vcmdq_id: The ID of the new virtual command queue
> + * @addr: Base address of the queue memory in the guest physical address space

Sorry. I didn't get this part.

So here `addr` is command queue base address like
 - NVIDIA's virtual command queue
 - AMD vIOMMU's command buffer

.. and it will allocate vcmdq for each buffer type. Is that the correct
understanding?

In case of AMD vIOMMU, buffer base address is programmed in different register
(ex: MMIO Offset 0008h Command Buffer Base Address Register) and buffer
enable/disable is done via different register (ex: MMIO Offset 0018h IOMMU
Control Register). And we need to communicate both to hypervisor. Not sure this
API can accommodate this as addr seems to be mandatory.


[1]
https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/specifications/48882_IOMMU.pdf



> + * @length: Length of the queue memory in the guest physical address space
> + *
> + * Allocate a virtual command queue object for a vIOMMU-specific HW-accelerated
> + * feature that can access a guest queue memory described by @addr and @length.
> + * It's suggested for VMM to back the queue memory using a single huge page with
> + * a proper alignment for its contiguity in the host physical address space. The
> + * call will fail, if the queue memory is not contiguous in the physical address
> + * space. Upon success, its underlying physical pages will be pinned to prevent
> + * VMM from unmapping them in the IOAS, until the virtual CMDQ gets destroyed.
> + */
> +struct iommu_vcmdq_alloc {
> +	__u32 size;
> +	__u32 flags;
> +	__u32 viommu_id;
> +	__u32 type;
> +	__u32 index;
> +	__u32 out_vcmdq_id;
> +	__aligned_u64 addr;
> +	__aligned_u64 length;
> +};
> +#define IOMMU_VCMDQ_ALLOC _IO(IOMMUFD_TYPE, IOMMUFD_CMD_VCMDQ_ALLOC)
>  #endif
> diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
> index 2b9ee9b4a424..ac51d5cfaa61 100644
> --- a/drivers/iommu/iommufd/main.c
> +++ b/drivers/iommu/iommufd/main.c
> @@ -303,6 +303,7 @@ union ucmd_buffer {
>  	struct iommu_ioas_map map;
>  	struct iommu_ioas_unmap unmap;
>  	struct iommu_option option;
> +	struct iommu_vcmdq_alloc vcmdq;
>  	struct iommu_vdevice_alloc vdev;
>  	struct iommu_veventq_alloc veventq;
>  	struct iommu_vfio_ioas vfio_ioas;
> @@ -358,6 +359,8 @@ static const struct iommufd_ioctl_op iommufd_ioctl_ops[] = {
>  	IOCTL_OP(IOMMU_IOAS_UNMAP, iommufd_ioas_unmap, struct iommu_ioas_unmap,
>  		 length),
>  	IOCTL_OP(IOMMU_OPTION, iommufd_option, struct iommu_option, val64),
> +	IOCTL_OP(IOMMU_VCMDQ_ALLOC, iommufd_vcmdq_alloc_ioctl,
> +		 struct iommu_vcmdq_alloc, length),
>  	IOCTL_OP(IOMMU_VDEVICE_ALLOC, iommufd_vdevice_alloc_ioctl,
>  		 struct iommu_vdevice_alloc, virt_id),
>  	IOCTL_OP(IOMMU_VEVENTQ_ALLOC, iommufd_veventq_alloc,
> @@ -501,6 +504,9 @@ static const struct iommufd_object_ops iommufd_object_ops[] = {
>  	[IOMMUFD_OBJ_IOAS] = {
>  		.destroy = iommufd_ioas_destroy,
>  	},
> +	[IOMMUFD_OBJ_VCMDQ] = {
> +		.destroy = iommufd_vcmdq_destroy,
> +	},
>  	[IOMMUFD_OBJ_VDEVICE] = {
>  		.destroy = iommufd_vdevice_destroy,
>  	},
> diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
> index a65153458a26..02a111710ffe 100644
> --- a/drivers/iommu/iommufd/viommu.c
> +++ b/drivers/iommu/iommufd/viommu.c
> @@ -170,3 +170,97 @@ int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd)
>  	iommufd_put_object(ucmd->ictx, &viommu->obj);
>  	return rc;
>  }
> +
> +void iommufd_vcmdq_destroy(struct iommufd_object *obj)
> +{

I didn't understood destroy flow in general. Can you please help me to understand:

VMM is expected to track all buffers and call this interface?  OR iommufd will
take care of it? What happens if VM crashes ?


> +	struct iommufd_vcmdq *vcmdq =
> +		container_of(obj, struct iommufd_vcmdq, obj);
> +	struct iommufd_viommu *viommu = vcmdq->viommu;
> +
> +	if (viommu->ops->vcmdq_destroy)
> +		viommu->ops->vcmdq_destroy(vcmdq);
> +	iopt_unpin_pages(&viommu->hwpt->ioas->iopt, vcmdq->addr, vcmdq->length);
> +	refcount_dec(&viommu->obj.users);
> +}
> +
> +int iommufd_vcmdq_alloc_ioctl(struct iommufd_ucmd *ucmd)
> +{
> +	struct iommu_vcmdq_alloc *cmd = ucmd->cmd;
> +	struct iommufd_viommu *viommu;
> +	struct iommufd_vcmdq *vcmdq;
> +	struct page **pages;
> +	int max_npages, i;
> +	dma_addr_t end;
> +	int rc;
> +
> +	if (cmd->flags || cmd->type == IOMMU_VCMDQ_TYPE_DEFAULT)
> +		return -EOPNOTSUPP;
> +	if (!cmd->addr || !cmd->length)
> +		return -EINVAL;
> +	if (check_add_overflow(cmd->addr, cmd->length - 1, &end))
> +		return -EOVERFLOW;
> +
> +	max_npages = DIV_ROUND_UP(cmd->length, PAGE_SIZE);
> +	pages = kcalloc(max_npages, sizeof(*pages), GFP_KERNEL);
> +	if (!pages)
> +		return -ENOMEM;
> +
> +	viommu = iommufd_get_viommu(ucmd, cmd->viommu_id);
> +	if (IS_ERR(viommu)) {
> +		rc = PTR_ERR(viommu);
> +		goto out_free;
> +	}
> +
> +	if (!viommu->ops || !viommu->ops->vcmdq_alloc) {
> +		rc = -EOPNOTSUPP;
> +		goto out_put_viommu;
> +	}
> +
> +	/* Quick test on the base address */
> +	if (!iommu_iova_to_phys(viommu->hwpt->common.domain, cmd->addr)) {
> +		rc = -ENXIO;
> +		goto out_put_viommu;
> +	}
> +
> +	/* The underlying physical pages must be pinned in the IOAS */
> +	rc = iopt_pin_pages(&viommu->hwpt->ioas->iopt, cmd->addr, cmd->length,
> +			    pages, 0);

Why do we need this? is it not pinned already as part of vfio binding?


-Vasant

> +	if (rc)
> +		goto out_put_viommu;
> +
> +	/* Validate if the underlying physical pages are contiguous */
> +	for (i = 1; i < max_npages && pages[i]; i++) {
> +		if (page_to_pfn(pages[i]) == page_to_pfn(pages[i - 1]) + 1)
> +			continue;
> +		rc = -EFAULT;
> +		goto out_unpin;
> +	}
> +
> +	vcmdq = viommu->ops->vcmdq_alloc(viommu, cmd->type, cmd->index,
> +					 cmd->addr, cmd->length);
> +	if (IS_ERR(vcmdq)) {
> +		rc = PTR_ERR(vcmdq);
> +		goto out_unpin;
> +	}
> +
> +	vcmdq->viommu = viommu;
> +	refcount_inc(&viommu->obj.users);
> +	vcmdq->addr = cmd->addr;
> +	vcmdq->ictx = ucmd->ictx;
> +	vcmdq->length = cmd->length;
> +	cmd->out_vcmdq_id = vcmdq->obj.id;
> +	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
> +	if (rc)
> +		iommufd_object_abort_and_destroy(ucmd->ictx, &vcmdq->obj);
> +	else
> +		iommufd_object_finalize(ucmd->ictx, &vcmdq->obj);
> +	goto out_put_viommu;
> +
> +out_unpin:
> +	iopt_unpin_pages(&viommu->hwpt->ioas->iopt, cmd->addr, cmd->length);
> +out_put_viommu:
> +	iommufd_put_object(ucmd->ictx, &viommu->obj);
> +out_free:
> +	kfree(pages);
> +	return rc;
> +}


