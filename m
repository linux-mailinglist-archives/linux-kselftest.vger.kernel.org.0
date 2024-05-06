Return-Path: <linux-kselftest+bounces-9542-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A4238BD3BF
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 May 2024 19:21:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38BBCB20D1B
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 May 2024 17:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB90157472;
	Mon,  6 May 2024 17:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="p5wj2tle"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2043.outbound.protection.outlook.com [40.107.220.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30C915746B;
	Mon,  6 May 2024 17:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715016075; cv=fail; b=lLTdWMIrZOfq2V+Tk3Ri0DhXVPeFE/8X4C0g3Xslb9b33a6kceWYDE0f1LxeqdiglPdgQQc6Bv9tBt15Cx2p658BIv4s4l9az8OycMRt4qpnL8RGob/dIrdZufbf4OIteeca0RP2Nn7XHHG96jo9wWq2bRitiI4ZlC5Cys5W64A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715016075; c=relaxed/simple;
	bh=Qklca73GcdBnNTFq8VMarp5lIURo+pjiLZNyF5G92fU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AYftRM/iqJ9ra4dBz1rWTXdYyyfQ72r6dJ8Cal3fgIOpG/X4xEcSw6DbKAePf5QtQ4XEMpv/kHZvzhxg/+sKtV/q1qflFjKoQcf36j4nrk7896SgtYBQznty+YumrudKeJM8tmyPk/2Yj3ESYyD61eO6MO0LzJeNmhPCFl+GumM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=p5wj2tle; arc=fail smtp.client-ip=40.107.220.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bnd01hWePVvGtmjEpexBSOgkeL3SgKfI1jhfyIz9GpMHtc7M0O8dmBJ9MVRwIRAZ6zBzBT7XfgohsaCJywZvP6UVLvBp5LXxIUJrwd3dvLoDyWQn3e247uTozcG+VuMuuLGZnC225R53vPHU69AGshw0OGqY8v4viihN0QPgkEejagBmvGv0EEnZsOmvyzaSDFL90P8yZs5KewHOerPeNjXRiFC9dKbxh5peND60Je7EGhkWJipF94UuzSQVsKK00lcnOAjtPY9+dMd592qtleLPvQPAzGb2ih3v6sQIzFJ9Tx3ZjWZYEh+/HCapfPV6Gs58sCDQzJYwwukWQv1AXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qx+PCMejNQHrPgDEtiVqatwTX/uBjlm54kOduBhfB5Y=;
 b=RlViw4vHTT9Y6XyWuR/PtqSreXEBVoqF3Cuxr0ZFlAFAoCWQx5cRn0RPGjqkuhkGLs2p72fjfn5A+8id9sWQhJMv+zHrj2h+BM/J8JKvfVBe6jjmvwyR9V6l58epwZS3yycNhpta4pbhwh5/7/XpyvzLkdkRos4JYz/UAFq/Ee7IRnE+MUOwYfngr6TJRTOQcNHt0MEHjf8/F3fdsu2dq+6wVk0yXaA1qB0H0axB5rV/5AP1ljp0MNIRsYMc7wHnMCeuoaKFXCWdDsD8nRDW9wuQdEOB96vnzef7Q6q24PjsrStsVGWTzWczJ8KkmCLdVzy7oi+q7tlkKOmEnD+mNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qx+PCMejNQHrPgDEtiVqatwTX/uBjlm54kOduBhfB5Y=;
 b=p5wj2tleuogw0rdNvl1CKIXukEocPjZqDGzH+KGK2HOCAk+hJ8P/rYjLbQj0fG5n1Zi8YrC3rJMp9v0D/yiFzEHAfAWM2XjU34zBtba3lsWO7e6qwPtOjBXk8WfFn6LYPBda5SplWXCXqQmLAApFNZvKDUN7snHyeMMLuWYwBLD0S8YyhJCd6mro2CuO+5v+MDvVFVNBlIHiv7ti6Pnm/c/Fq7qzAzYeu7rp3CKCnfsn/D2Ng3lIVDol0qtNAk1mKbj60ii0K3AMc/9ifGGaTQEiQnr8iQBEfIu6d5BtGpBiFh1K1dthakBhrgw9ZcjAUMmvtn1+Bdrd8AEfbyhGow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by SJ2PR12MB8184.namprd12.prod.outlook.com (2603:10b6:a03:4f2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Mon, 6 May
 2024 17:21:10 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%4]) with mapi id 15.20.7544.041; Mon, 6 May 2024
 17:21:10 +0000
Message-ID: <d93c08c2-6fa8-4c3c-8887-f5ccabd7777a@nvidia.com>
Date: Mon, 6 May 2024 10:21:01 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/resctrl: fix clang build warnings related to
 abs(), labs() calls
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Reinette Chatre <reinette.chatre@intel.com>, Shuah Khan
 <shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Fenghua Yu <fenghua.yu@intel.com>, Valentin Obst <kernel@valentinobst.de>,
 linux-kselftest@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 llvm@lists.linux.dev
References: <20240503023209.80787-1-jhubbard@nvidia.com>
 <793bd068-c3b4-6330-41a4-bea597b1d820@linux.intel.com>
 <f908ba74-86c0-409c-854d-9da5f3917b05@nvidia.com>
 <26f3effc-6ea1-4670-a301-76df3a710fa9@intel.com>
 <b88e73ea-d3f6-42d0-b9e0-f97665546178@nvidia.com>
 <d46b81df-e018-a9bd-1550-31c825c487cf@linux.intel.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <d46b81df-e018-a9bd-1550-31c825c487cf@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR21CA0025.namprd21.prod.outlook.com
 (2603:10b6:a03:114::35) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|SJ2PR12MB8184:EE_
X-MS-Office365-Filtering-Correlation-Id: 50dd90be-9efe-4d0e-2b99-08dc6df0ec68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|7416005|366007|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MFRIaDlIR3hMRk9TeFRqdytGdHJjOG1ORGRqbmI1eGZSOU8zQkJ1SnpEMzgv?=
 =?utf-8?B?WFdPdFJuWkcrNEpUZU9aNW5uRVRDV2pvbThEVndBbkpvejlUV25sRTVFeXlk?=
 =?utf-8?B?NGxHdTRPS3BndTVaRkNXMklEQ1J6NEZrbC9aQktaSkorNzFuNGU1L2I1cUhS?=
 =?utf-8?B?b0FzY25QZDU5eHh5UktJeVhOY2VSQWdBbTFvZFY3WWJaM0dBZjlOZlhPNVdV?=
 =?utf-8?B?N2RROTNvQjFqdWdDYkNQVkZISmloU3RoT1lxV3p4cjhPZ2NPaktMdVRiUzFu?=
 =?utf-8?B?R0h1dFJLa0tiQktzUDFGMXFBWmlRNlhMTGRuR1B3ZURMRTY5eXVWODN5aC9S?=
 =?utf-8?B?dWRqYXQ4Um5ydnBwL2xWZmNpRzZGVUZzeHd0Z2luZU1nSHVxS21qM25wYzVl?=
 =?utf-8?B?eWgybEMxZ3p0QWF3NVZEKzA1MmVEVjFlVGdDNkdaNldyMjJvdTFZcStjNUxm?=
 =?utf-8?B?b3NoRmhWZnhoMHA5SUd4b3hkS1o0ODk4NjhJU1IyenJGWFhOVTdSTVJoR05I?=
 =?utf-8?B?dWQxdlBQczlsZUxBRTlEMXh5K1A2N0xxamd0dmVvNUZUQ0N2V3VWQ1l1NjhU?=
 =?utf-8?B?Nk8wclpGdENRSlFCckRRUzBIWjhOVURySkx4eThwK3NIQ0N0YzJvc2dZaE5r?=
 =?utf-8?B?OFZoSmZCanl6OWVRZVhhWnR5VmxlblNLazhwL2VDUUFodnZ2cXg1OEltRWtU?=
 =?utf-8?B?bXB3T3dvbUsyMmRzOG9GSWJ0bVUzaVNpU0FzRFJOdS9VSTVTV0lBeHllS1VS?=
 =?utf-8?B?SkZGVXJReEVKNm5odmpuMzl4QzZ3bXN2SzE0N25lVnpiQW1nSS9kakUydW04?=
 =?utf-8?B?bE9ncXozRE15TjhGeGZTZHhiMUpITzhmN2xERkxCUzFreklUWFl1K3pQRHdX?=
 =?utf-8?B?SWRSWnpITjZxQy9vZVpNaTRKbHJTUDhvZmU3TXpnaVVxZUltYXE5VkN0Mkx6?=
 =?utf-8?B?ZytQcWorbENHRWplUXJTNnhSQWIrY3UvWHpGQjUwK3NOVEJBZEViZ1N1dVZa?=
 =?utf-8?B?TnRrMHQ1SW5ibkhLc21nd3E5TVFOTkd6ZGJKM1JOMkR6d1lQZ2RNZ0VvcTJF?=
 =?utf-8?B?Ym1rNW1zM2NWYlhLZkVXMXVBajVyYXJMelFXc0RjSUYyUStHcllRdzI3dnQ1?=
 =?utf-8?B?THVJVURpR1VSRU1rbm1CMTR2Y1JRRWIycm92cC9hT1VTRmp1WnJsMEY4TXNP?=
 =?utf-8?B?VnhCdVg3UXA5bG5VSVdvRVlUN21Idkxpc0FaUll5YzdLZjNaV0FyazNpMWZs?=
 =?utf-8?B?K3dkNEJiTVoxUFpXdXBFemNjRlhyTEswbG5WSjVnUnpsU21KWGE1cWpPWlpZ?=
 =?utf-8?B?ejZaREszNjRVVWE0MmtsaHRYV0VJbk5sV3o4REEzeTJPK1RLUktoRkxvVDRr?=
 =?utf-8?B?S0JWTjI2UlFjRVIrWm84Vm56cVllVE9JRlJtYys5R1FZWXBOMnV6T0lNT2hV?=
 =?utf-8?B?TlBFeE81ZkI5WWRRUXJvbkl2ZnZ4UkEzanRMTWZjQVpSdUVGWVo3bVhFc0sz?=
 =?utf-8?B?dld0ZHF3VGkzamN0dGR4NTNmVzRSVXQ2R3lNc3dVQW1tS1Z4T1MyS1JvT1lH?=
 =?utf-8?B?WFF6SkUxQTZReUdGK1BDdzZ6YzVSS2Vma0lkWHRqTFNxZ1BOb0cvcEpuNlNx?=
 =?utf-8?B?UWVVNDFSUDJvVW9IcTkyK2tPQzB0U2VRZmNPb1BsZjRzQWVEN3pObVhxS2RN?=
 =?utf-8?B?SENzS0xBRGUrYm1VQThvUS9objR1M3dwVm9BMGU0dElwQ1IvTkNnYnJnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NGFYRWYrM2JmVWtnOVhTTXYzTENQWkNkdDNxVi9nN3NxbU1NQ1JkZS9QSlp4?=
 =?utf-8?B?Z0NpWE1tVGNjYlB1SUVSWHNGQVBjTXc2QTVxbFdSUHF5ckwyY2ZMLzJiZVJK?=
 =?utf-8?B?Z1Nxdm1UeDBsUlhnYjZXVkhkQWZKMnNQN3hmS3o0TCtpSmF0a2VicjhmUHRp?=
 =?utf-8?B?ZFErZnMvUjlPUzA3NHRiY3UrZ0FXODlHM1RCKzBQaDhBc1hqbFJHQ3NNVm53?=
 =?utf-8?B?dFhzZDJYLzFCYVh3a3RXMlJrR2ptaFA4a0hOVHk5anh6QkF6QlQxTHJiR28w?=
 =?utf-8?B?TEJPVWo5MWdXaGc3TExPOEROR2p6TDJiL2l0dldSUzQrSjI3V01meTF5d2hC?=
 =?utf-8?B?dDRVbER2eFdEVGRRbW5uVDFPQndvRGVCYkUxNUNPbENoLzVwUEliMHRxWnkz?=
 =?utf-8?B?UVBSZVNEMHJLRWEvNmxzM0RUUVRIanBpVDNPQ0xQTk82d1owYmlsSzdyM0VO?=
 =?utf-8?B?OVBlWmo3dmEwSWJGVmdhV09WU3dzSVlyaGtxMm9hU05KRVgzUXIzVUNBRUlM?=
 =?utf-8?B?R1JlbDJwUnBpR1k4NDE4WkdEaWFiSzR5NjJha29XY2FWaHl3TDlPckQ0aG5h?=
 =?utf-8?B?d3ZFOEhoM1RrRlR0aWMrMlRveFN4WVRKaG5GTDN3WkYwdG1MMWI4bGdZWThw?=
 =?utf-8?B?T2JIMWJoeXZwdWJDMVBNZUE0bEpvekwweFl6cXRENzVDWlFvTU0rd2ZPejlL?=
 =?utf-8?B?RDlQZjlkbHl1U1JSc3N1TkxSTUlIQjlBcEpTSmFCakQ5SkNOMlVqc2F3aTNk?=
 =?utf-8?B?Z1BZUXFmZzFNbUZXVVBqbmJyaHY2Z08zQTBiNjA1OXlZZHdzTjl0RThmdVBB?=
 =?utf-8?B?bnl0TS9WRFR3OHdLTHZ0eGZ2MGtEbEZhWjQrL2Qrc0h2T29ha2RDZ3ZURTJx?=
 =?utf-8?B?VUdISVVqbHczMWNxekkzQVExVFF6diswdDAwcEM2eHlSVWFPY1l0S3poUGti?=
 =?utf-8?B?enVPc283bDQ0RE9CTTNEaVE5d245c3FxKzFwNXEvYVBkS1UwZG1la1dWb1E5?=
 =?utf-8?B?L2Fnd0JJcEpGWXBKQmhGeFdIaEpzajZEV3M3dktHLzRMS2ZqZ1N1Z2NMaDNp?=
 =?utf-8?B?REFZOWRraDdhTXlzNnNZZVdZUU9pUFhibk5zRnJpTkJFRjlBeXJJMWdFWkVZ?=
 =?utf-8?B?RGprYlRLd0E0NXlpa01sWm5pUHQ4L0dYeDNKVVdlRVJoSU1MRzlNT01kZWhN?=
 =?utf-8?B?dElRWThKTVkwaUdVKzgvSkZWZXIvOEFuSVM0cFBJSmUrcHVzT2xOVnpmaGQ1?=
 =?utf-8?B?emFGeU4za0xEM0EwYU5wL2dtcXE0WmRmSWFYZ0xDQTZDTFU1ZEQwT1dXSWJk?=
 =?utf-8?B?QmZrRWptTXpNYiszaUZ6VlpYMzRHL3VCN012RDVUbXZua2dYWnZwRjRyY2dl?=
 =?utf-8?B?eUtpaTQrb2dVOXpxRjlrSkpSRTNyUHh1bktYTzJvbEFQcUdkalJDOGJQc3RL?=
 =?utf-8?B?Y1hGWWJNbUh5UUFrL29acFc5YUVPVlhjeHo4NkI1K2JDaTZJUkE0TGczazR3?=
 =?utf-8?B?NzIzRm42RkFMRWpHb3BRRjZnUjNWaUpGN3pmMG16SkJtaDVDTXZhVExiQVRC?=
 =?utf-8?B?aGxXOXc1cDhWOWdyTXJjbVBDNFNkNmg1TFdSSFZyQUdqc2dhWkZjZmtTaU5a?=
 =?utf-8?B?WE9WVHVWWXVYaVB5RFBDb0hnbDEzcklEM2E2ZTdzdmxNbEVTVGYwQWwweU1k?=
 =?utf-8?B?bkswTDZjTWNoL3VvVExwN3JwOTNubW5VSFZZOGw0RzJsaEk0OFpJL0tzL3pR?=
 =?utf-8?B?ZHJWeGhzMDVFbktFSzduV3U1elZPWjlnNEQzSFo5R0pHdjRMLzJEOWN0SHMx?=
 =?utf-8?B?Q3U5dVVXOG13RUVvWU5rNi9hTkVoL1RHZ1JQTkFkeHlJWTNLWXRYUWFSSDJh?=
 =?utf-8?B?K2ZTNWJCUHNZUmtmMk90M3ZhRDFleGY0NDl2N1VrNzZ1Q3AxRGtHZnQzZGts?=
 =?utf-8?B?RFFJbXY0UVlKdk9sN3k2enM5WkhZYW8xRi9Ga0NFUHFCeTlmKy9tNDFIVDEw?=
 =?utf-8?B?ak83NjIrd2tGYkpXY2hoRmhNbldBbkVaSVdyRzMrdmRMd3NqZmVHSksxUkxw?=
 =?utf-8?B?NC92UDNGRm81NXVXcm1JM2x1Yys3ejhNdE5rSVJQM0ovbkxHaDJHa0FWQUpu?=
 =?utf-8?B?VEtMNjRyUlNPdnlqRzRTbU1aenFDZ3cwdHNaMU80VHFwenFRRTkwcHVPdUNz?=
 =?utf-8?Q?8gAne6suHeRoSzHqC28+81Y=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50dd90be-9efe-4d0e-2b99-08dc6df0ec68
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 17:21:10.7156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dtZbbF4xn4OjEnW60+oIGns+1SjJePC+rIFSYL4nO9O5+R+cbWkC9fZAmFotjynSi6dPO7Ha53n+EGeUjvOHsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8184

On 5/6/24 2:07 AM, Ilpo Järvinen wrote:
> On Fri, 3 May 2024, John Hubbard wrote:
> 
>> On 5/3/24 11:37 AM, Reinette Chatre wrote:
>>> On 5/3/2024 9:52 AM, John Hubbard wrote:
>>>> On 5/3/24 1:00 AM, Ilpo Järvinen wrote:
>>>>> On Thu, 2 May 2024, John Hubbard wrote:
>>>> ...
>>>>>> diff --git a/tools/testing/selftests/resctrl/mbm_test.c
>>>>>> b/tools/testing/selftests/resctrl/mbm_test.c
>>>>>> index d67ffa3ec63a..c873793d016d 100644
>>>>>> --- a/tools/testing/selftests/resctrl/mbm_test.c
>>>>>> +++ b/tools/testing/selftests/resctrl/mbm_test.c
>>>>>> @@ -33,7 +33,7 @@ show_bw_info(unsigned long *bw_imc, unsigned long
>>>>>> *bw_resc, size_t span)
>>>>>>           avg_bw_imc = sum_bw_imc / 4;
>>>>>>         avg_bw_resc = sum_bw_resc / 4;
>>>>>> -    avg_diff = (float)labs(avg_bw_resc - avg_bw_imc) / avg_bw_imc;
>>>>>> +    avg_diff = (float)(avg_bw_resc - avg_bw_imc) / avg_bw_imc;
>>>>>>         avg_diff_per = (int)(avg_diff * 100);
>>>>>>           ret = avg_diff_per > MAX_DIFF_PERCENT;
>>>>>
>>>>> But how are these two cases same after your change when you ended up
>>>>> removing taking the absolute value entirely?
>>>>
>>>> All of the arguments are unsigned integers, so all arithmetic results
>>>> are interpreted as unsigned, so taking the absolute value of that is
>>>> always a no-op.
> 
> (I see there's a better patch posted already but since there are a few
> incorrect claims in this discussion, I'll do for the record type of
> reply.)
> 
> This discussion now went to a tangent about the warning. My main point is
> that logic is not correct after removing labs().
> 
> I also disagree with the claim that using labs() on unsigned value is
> no-op because labs() takes long so unsigned is just forced into signed
> when calling which is why the warning triggers but it's very misleading
> warning (see below).
>

Yes you are correct.

>>> It does not seem as though clang can see when values have been casted.
>>> I tried to do so explicitly with a:
>>>    	avg_diff = labs((long)avg_bw_resc - avg_bw_imc) / (float)avg_bw_imc;
>>
>> The subtraction result will get promoted to an unsigned long, before being
>> passed into labs(3).
>>
>>> But that still triggers:
>>> warning: taking the absolute value of unsigned type 'unsigned long' has no
>>> effect [-Wabsolute-value]
>>
>> As expected, yes.
> 
> That error message isn't factually correct:
> 
>          unsigned long a = LONG_MAX;
>          long b;
> 
>          a += 2;
>          b = (long)a;
>          printf("%llu %lli %lli\n", a, b, labs(a));
> 
> Prints (at least when built with gcc):
> 
> 9223372036854775809 -9223372036854775807 9223372036854775807
> 
> labs(LONG_MAX + 1) won't work though since it's not positively presentable
> with long and the value is left untouched.
> 

Thanks for setting the detailed record straight! :)


thanks,
-- 
John Hubbard
NVIDIA


