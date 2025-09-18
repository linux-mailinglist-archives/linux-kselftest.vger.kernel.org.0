Return-Path: <linux-kselftest+bounces-41838-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C78B84C38
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 15:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB1737C2190
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 13:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A261E306B32;
	Thu, 18 Sep 2025 13:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="dOYem+qS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013055.outbound.protection.outlook.com [52.101.127.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5DF30BB83;
	Thu, 18 Sep 2025 13:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758201372; cv=fail; b=RseYs+2ttd3HtT5acpSvHP5tX2DWKPPMRBtdbe26jocY3CGVtoadDZjzaBn+cxoZQpvxdwOPDb229xVmi4Yc7BGLWJV02O3a1057E2E98uyVXoS7Cw1UiQLcIH/PIWTR2oXbVAtaP49nJrBTjciwIpl9HfzJLIxYn74VwAs/iuI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758201372; c=relaxed/simple;
	bh=0U/6oBEz0YmxmiGi13GIkox8aV9l+h/t9uuIfA7LxQY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EjQeN178KzyeTN0n8XMZ+ol2JyTV9OfeftVYk92uBWNh2eKKOb16TaJtISAxB9Ts9DYjFAgw902bHForsbhAJedeDt+yln62ZC0ZeGrVJC7NnVU7V+MRjYH6HFK2zsnWkeU/v16qO1ZcuPNtNHvA4NtxApsbpv7JdbU2gSfX0qM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=dOYem+qS; arc=fail smtp.client-ip=52.101.127.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lrsQKD1u40isR5gabMjoW5kfc/l8TgWszBSdmH45h7ARv6i+3B22dSlZl8/+RGaMbLTNIdQ41fvSyzJZEl7D4LwM3wp8VCHg00ngAo/G0zIqYpWq0qe92T03E8X+hwidRQ1DSs8oXjF5DJAPj2q5nbXdAt8DXaD0OZmOKisBH9bz+WxVxUPs/AwtAToM2Y8EmhxjsOIpCKdazpYANHsn8it1wdMvQqzG27E4MVoZplxNvYsHqOJ4wcAe0gTHnkME6dWaLJGVRoPD06e9lVv5aIGMfezxh16KfudHEdo/vi/KdLiAKLbMHOJVX0up8De5nZxvCUFG952uWlJtb0dVaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cEghoWD9K5MBUnJtIxJqXf3VotDZgDyvM+SLCqgU7eE=;
 b=g4Pukpfqi9zLOIf2zlOtsdeSKeOGiSTbr9KCkeQk8vOcCPvFggZPEmiI4lccfioT3T+fBQqI13Ycws5Uw434HnjrfcaPkpya+GjziHkVFSPdD28gYwChFKGhV6xKUcdXLenntBZ37n8eFeVgWf8dZzRW7o0w/w/g2z33K1KhwIc3lij+yWJCJCfYrYhxE+i2jK/tJXr2zD86ITd6LaafteBkKLQy3wo/BBAcCOpRFPkU0s96ihyDx+jb8LS3S2c8z/TY+imCNo/V6TZ0hdlOIfIPmub5RreYxqcXhs+2iTQ27CQZbFLbm4usZCQkr/Mg2PghsJBFdG49LYkh2Y1RiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cEghoWD9K5MBUnJtIxJqXf3VotDZgDyvM+SLCqgU7eE=;
 b=dOYem+qSGZO/cchGJRQ+ogQuPEWYPabyIdxnfVjBPLIumgkHZ5sK0nCDHk1Oy6MpFE42iEwHBiMUyVdGG2Dod+fRkEjDOwC4cGDNYsss9aw4avtLpmqU69vECy1kzdOs3oJJqmYD+qPzta18ZnKsGX+fP3AfHo1XzaxmhDMx0eT5Ry7pW25bRhC5y/4CryPoVVZOTFuqs0663t0b0V5sutPst0Dz6UQC2EU99S3B9+dHxWr1EGfdqmn9s2E0Mi9QHveFAzL8VCMsr+cd6IW7xNw9E7O3NvUkH4rlOpwYELdUwtg0dQW2cyc2vsFWhu3RUll20jdNgNDSg/+FnuAbfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com (2603:1096:301:b5::13)
 by SEYPR06MB6182.apcprd06.prod.outlook.com (2603:1096:101:df::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 13:16:04 +0000
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571]) by PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571%4]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 13:16:03 +0000
Message-ID: <9cb5b3d5-97bb-4165-9a84-394d3d45a20e@vivo.com>
Date: Thu, 18 Sep 2025 21:15:57 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH bpf-next v1 0/3] bpf: Add BPF program type for
 overriding tracepoint probes
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Song Liu <song@kernel.org>, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, yonghong.song@linux.dev,
 haoluo@google.com, eddyz87@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 shuah@kernel.org, willemb@google.com, kerneljasonxing@gmail.com,
 paul.chaignon@gmail.com, chen.dylane@linux.dev, memxor@gmail.com,
 martin.kelly@crowdstrike.com, ameryhung@gmail.com,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 yikai.lin@vivo.com
References: <20250917072242.674528-1-zhaofuyu@vivo.com>
 <CAPhsuW47BVGsszGU=27gKa1XOYLH+de1FgrHPVL4mftB2CvX9g@mail.gmail.com>
 <b23ef4e0-afa1-4d94-b4aa-28c02c3499c6@vivo.com> <aMvHE-iW5eAwf4km@krava>
From: Fuyu Zhao <zhaofuyu@vivo.com>
In-Reply-To: <aMvHE-iW5eAwf4km@krava>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0034.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::10) To PUZPR06MB4742.apcprd06.prod.outlook.com
 (2603:1096:301:b5::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB4742:EE_|SEYPR06MB6182:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a68bc16-9eb4-4513-6f53-08ddf6b584d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aGxlaGhCWkovZ0ludUV4bWkrV1c0TjE4ZFNRL01ha213bWZQUEkxdGVNTUJM?=
 =?utf-8?B?MWdHd0pMMk13akZxUEVPa1gwa3krLzhlamVwTnU5aUJNNWladzk4bkVhTmd4?=
 =?utf-8?B?RzZmQVhkaWVDUjc4Snptbjl3Uy83VWRwN2NqRzdWQUJNL0R2cytxMGQ5Rzly?=
 =?utf-8?B?dGVpNFViRE5MWXMyK3ptTTl1VyszK2llUXhvazJSc3J4N1VHVUZ2TGI5OXVQ?=
 =?utf-8?B?bllPa1hmNGwyZHlMb2hxM0JYbVJzYVA5MW00VFFCbDEwTzFzQ3g4TG5MVStH?=
 =?utf-8?B?eEZ1aU1KVmxZV3VrUmtRaFVDN0Z3MGQ1eHl5U1lNOXd4OGxFcGt3ZGIwNTNx?=
 =?utf-8?B?dWYwazUya2luaVhBWkYrazRpdmc5OVNtL0RVNmgzQ0lwZlY4K1lma0pnZndJ?=
 =?utf-8?B?WXA5TE1VQUZrTjduSk1HckRDUGkrN0RnaWtCdnUxcXI5SXlPdlh6ZG15MVNW?=
 =?utf-8?B?WklreEFXL1hMNnBiUzJGYkZmQ2Naa01jQWVnamRoR250Z0V4MElOa3VnWG0y?=
 =?utf-8?B?dWZlVWRJU0pOU0toR0ZhYlRJRWFFMFpjbHcwREROMkVEbmQ4MXA5RCtJNzdn?=
 =?utf-8?B?aG0rcXk3UnNGNDJiU2Nqc053cFIyL2Y0ZU9FZksyT2Z2T200VmtJU3d6cGpC?=
 =?utf-8?B?SzFqN1A2cWNVeHZaa1ljRkZtY1FuQUliUlN5bzRQZDcxbmJ2SnIyVWZEc0VN?=
 =?utf-8?B?a0F6ckRoaGNvWU1ueGVxSXVJam5xcTFSQ1dSdWowbXkvR2QvWnI2eVB5QXUx?=
 =?utf-8?B?Qkx3M2xHbWd3VFlNLy9uRkI5VFNoa1JPY0NVVWx4OWEwRlJhMjk4NWFKaHox?=
 =?utf-8?B?bDBRQzBmNnZpMUZWNXFaMXJDVHc0cHBpb1hiUnpTNjc0bTduK3QrVVlTUHRL?=
 =?utf-8?B?NW8ydWxlK2t2MURTU1c3RUJNbXJmQUtKdHJGYVI3Zjg0RHgyUjlrR1hqQzFp?=
 =?utf-8?B?eXFkVlUyK2VGYmhXVjBVclk3WVBBOWt3MmVTZGg4MGtzYjFyUHM0NW5pM21q?=
 =?utf-8?B?UXRyOUFNdEI2bGxWK0tOU1BGYjgvbnI0MHoxQkROSUJXSVR6NlpFaCtvNDZI?=
 =?utf-8?B?ZDJRa0VhbEZOQllxekRLM24yY1N3dUhGUTVtSmtmU0lHaDJQSTJGTlpGeVpZ?=
 =?utf-8?B?MzB1OWpEV0VpZTRJMkRrcWZjZzJRTDFEbmh1RGRZRzhyOFVCbFhCMGpWOWtO?=
 =?utf-8?B?YTlJZVpWaXdSd2FqaW9BQWVFY1YzU3FDOStISFY2cEt3TDU0Y2VGQVBwOFBW?=
 =?utf-8?B?VktpdVVHNmNscTJwRW5IeGVQZXYyOEs2WGptSUpaZ0d5eEh6K09mQVdMRytV?=
 =?utf-8?B?cXI4L3RSRUpkR2N3MURzcXVvcjY1dm5lZ255WXVMRC82OGhVZTlyRUFLRlFM?=
 =?utf-8?B?MlJFTVRRbnR5QWs1dzl6bHVIUnpOek5KYTN3d3BxdngyR1N0aWZBTnNEajZk?=
 =?utf-8?B?RXlkRmJXaktCbkZvdFNTSDlyaEl2ZXpsdmw1NS9QN1p0WUkyS2VJOW5PUnAz?=
 =?utf-8?B?UVgyemQ5UGFXOEJJOENEellTQ0RGMnJWdDBoaFY0OVVKTmVVNm44a0hsM1hE?=
 =?utf-8?B?c3dMYUlMZVB0bVVVK09wV3kzY01vUnRjc1ZGeG5ETVVqMXU4M2NBWHlQdWpp?=
 =?utf-8?B?M05kTnUyM1lZK2ZLakwyMzM4Rzc4WldRQXJPQWc0NnROMEtpYk5sWEV3SG5u?=
 =?utf-8?B?OHBEUWtabG8rMkFLVDYrTVg0c0VlQWRSd0s1M1AzMnJmQUhkR05FT0V3OGcr?=
 =?utf-8?B?bWhlS0JsRjM1VzF3ZU9Hajh2UXRuRmRGNTk5cTBuZ3FqdWdLYXNIWDNGZ21W?=
 =?utf-8?B?ME50MGMva2wwd2JlV2MxN1NVSTMyb3JsYlZpdCtUc29MWTdJRk5yZUdnUStH?=
 =?utf-8?B?eVJLV24rZUlCN1I4L0lkeURnczluTThKS0hnTmVWN3l4ZVEyOTdoMmVUcVll?=
 =?utf-8?Q?kmRpcA3wTeQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB4742.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZldjYVVLV3l0eEtER0laeDM3SkRRVTAvaEQvbmRDeC94azBndmtlSjdnS0tz?=
 =?utf-8?B?LytyVEJLbDlGTjhUTGJoZWpIZXpaRk9obVBRZjZ5TTIwUExJaE5MMDVNZ0Uz?=
 =?utf-8?B?U3A1aisvVlk0WVkyWGRFdFRIWmkvUjVuS3BUWkg4ZlhNRVg5UENqMnA1bWor?=
 =?utf-8?B?T1A1dTRJVnd3TzEzT1picFFwd1Z1K3pxbXJPajVLSm1XSzRsbXhIOHdnbTB4?=
 =?utf-8?B?UExaT09sbmxabnhZYWx6Tk02MjN0Q0dEcWlWUEJuUjVoaDA1TnVhMHM5MCtw?=
 =?utf-8?B?SzJSaUVoeGxWdjNwVmtoTGp2U054NXhFd3ZscTV5WUl0SHF3ZndVckxTOURG?=
 =?utf-8?B?WUZKL29NWnAyV0lBcmdHalIvZGxaeUF2WE94eVNWcklvSWcvbXhqUFNkQlhI?=
 =?utf-8?B?aWd5OXhqczlWazlHSnBsSFFSeWh3ajlsNjNnNEhpNWlDNm52TkFqdmhoTUQ0?=
 =?utf-8?B?RFRwQnZZZmcrMlI1bVN4N3NDOTlPbC9Pd2h4b2wyRHYzYlNEYmJwcm5wVGM5?=
 =?utf-8?B?dnFDWWZZSWQ4ZURlcFU2K1pqNGJ2M0w3Uk5VSlU4ZTlOeDlhVHVxZlZVdFVa?=
 =?utf-8?B?UkdtL2hEUUdCS2JoZlcyeCtEdW9TL1Jud0l3T3ZuU29KOE5SUWFNNFVucHI1?=
 =?utf-8?B?ZU9wbi9NNzVHVW1aWHFuUDNBWGQrN1k3Uy9YMWlKN25WV0VVRmhPUDJqZmZS?=
 =?utf-8?B?cXg0TjByL05RRnZxYVBBOHI4YVdjMGFvZUxteEhFd3c0VTU5eDNOMHpLK1Fo?=
 =?utf-8?B?U1pKZmdEcHBWZ2F2ZW1RUUtIWjA2Q08zUkNoM0YzTVBQcjFIc1h1ZGxLNVIx?=
 =?utf-8?B?SzNlMmN6UGlwMTlUV0YxS1JYNFRadytjaXQwZ2NYRXdsczJzWk0yZHRSZjlh?=
 =?utf-8?B?S3p4Zi8yOWhiUXFqOXBJSExxZHFlSFdDR1ZpUC9PRzd4dk9sdmUwQ2t6enNs?=
 =?utf-8?B?b0ljOXNSNVhrL3dRZURPbmFyZ0VnZzU0dXlJbW9tRjY4eVlwYlFPNzVTOGJN?=
 =?utf-8?B?a1MzSkowR2oxRkEwSHRhTGpDWStJeGVHbkZ4QXUxbTQ4SlB1RGVIM0t6NHd5?=
 =?utf-8?B?VmFBN2JKNGF4ZjRpV0NRRU5sRnlqQ3YzM2ZveWhRRTdjVEFXU0JSYVNVZHJG?=
 =?utf-8?B?M1lnc0hmM2xIVTl5UmhaMkpVV0xxdDllYldpMjAySkVUNXplNzBoOW1lM2NS?=
 =?utf-8?B?c0oxRjBjbmxIUm5PNW8yVGsyY1VUUDYvUk9YRlhFUERuOVpLWTl3WnVwcU01?=
 =?utf-8?B?Qmx4MWpuSVBsaUxmeUdUcUN1eUJUYy9sVUh6QmR6djdKYnFsS2JtMkRZdVlq?=
 =?utf-8?B?YmkwOHZSRlIyaExjTUh4TjlaSnFwTENEL1I5Smh3eDJjNHlCZlBJanltbGVL?=
 =?utf-8?B?M2J3eDFMUmhqalVLYjhYLzNmVVJyL3g5NTJnanFIcXR2cGd5eTZveno5RDlx?=
 =?utf-8?B?VDlxYXk1cmpINzMrZGFQWDRKZjNUNlBMQWNxMzFVck40MWtZQis1Smhkc2Vl?=
 =?utf-8?B?bnV6bmIyY2kyU21aMG4waFV6U21VMVZ6VG42c0RaV3BnQ2htMmR5RWNCRTlZ?=
 =?utf-8?B?VWVRYTNxUi9sRWpTUlUrdVBkczJJdWd2RkRPdnQ0dm9mR1R4c2dGQ3haRE84?=
 =?utf-8?B?N1Zmd2FFMjg4c3lLNFE0TkZYV2g0RDBPNlVRYU9IRzd4a3hLY0c0U0xWbHNk?=
 =?utf-8?B?bzVxOE14aFZJUnFzTXZhQ1BzQm5MbEJJNVZ3Nnl1YnJuQkR1UUtaRDRUelhM?=
 =?utf-8?B?T2JpT1E0bmNVa0ZoYkNlR25iUnRVRkFVMjZxZHNRdGNZYWpndy9jODZZcUFQ?=
 =?utf-8?B?ditnSmRZcGs3Y2dQMU0xRjJIMzhmZCtiYlloVktydTZibUpQZDROekk1U3JF?=
 =?utf-8?B?QU5ySFplSWhtUVZldFhQZGx4L0EzMSszRHNuUzh4NlRnSFUyZ2NrZjRhU3hs?=
 =?utf-8?B?NWpvZ0gxdVMzRG9aaVdET3d1LytDWnM1WnNadm0vL0wwSm1KbjNLZlppdk5I?=
 =?utf-8?B?djRhMS94Mjd5M29TekhRNkFpYWdObGk1SkMzSGJvMWwxK1VOUkhRSkUveHBl?=
 =?utf-8?B?NE5Oc3VOQkJBaVdvdnpzeEtIRjRlRWxFM3JEVkl5c3hVazQ4WWZCT0pDdGY3?=
 =?utf-8?Q?a0ZFkdl9EAQFi541cjN0GSWKr?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a68bc16-9eb4-4513-6f53-08ddf6b584d0
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB4742.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 13:16:03.7122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b8VncOLMEueMMMGupibrYEEoV28m9LadItHdwBo7vmTbRAOBg2F17yCR4WhVO5qDHDAgPAYfyNM3OuIlibaFPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6182



On 9/18/2025 4:47 PM, Jiri Olsa wrote:
> [You don't often get email from olsajiri@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> On Thu, Sep 18, 2025 at 04:05:51PM +0800, Fuyu Zhao wrote:
>>
>>
>> On 9/18/2025 4:02 AM, Song Liu wrote:
>>> On Wed, Sep 17, 2025 at 12:23 AM Fuyu Zhao <zhaofuyu@vivo.com> wrote:
>>>>
>>>> Hi everyone,
>>>>
>>>> This patchset introduces a new BPF program type that allows overriding
>>>> a tracepoint probe function registered via register_trace_*.
>>>>
>>>> Motivation
>>>> ----------
>>>> Tracepoint probe functions registered via register_trace_* in the kernel
>>>> cannot be dynamically modified, changing a probe function requires recompiling
>>>> the kernel and rebooting. Nor can BPF programs change an existing
>>>> probe function.
>>>>
>>>> Overiding tracepoint supports a way to apply patches into kernel quickly
>>>> (such as applying security ones), through predefined static tracepoints,
>>>> without waiting for upstream integration.
>>>
>>> IIUC, this work solves the same problem as raw tracepoint (raw_tp) or raw
>>> tracepoint with btf (tp_btf).
>>>
>>> Did I miss something?
>>>
>>> Thanks,
>>> Song
>>
>> As I understand it, raw tracepoints (raw_tp) and raw tracepoint (raw_tp)
>> are designed mainly for tracing the kernel. The goal of this work is to
>> provide a way to override the tracepoint callback, so that kernel behavior
>> can be adjusted dynamically.
> 
> hi,
> what's the use case for this? also I'd think you can do that just by
> unregister the callback you want to override and register new one?
> 
> thanks,
> jirka

At this moment, I don't have a real-world example. However, I mentioned one
possible use case in my reply to Steven:

> One possible use case is CPU core selection under certain scenarios. For example,
> developers may want to experiment with alternative strategies for deciding
> which CPU a task should run on to improve performance.
>  
> If a tracepoint is added as a hook point in this path, then overriding its
> function callback could make it possible to dynamically adjust the
> cpu-selection logic without rebuilding and rebooting the kernel.

As for the reason not to unregister and register a new callback:
callbacks registered directly inside the kernel cannot be unregistered from
user space. From user space, we can only attach additional callbacks
with BPF programs, but can not remove or replace the ones already
registered in the kernel. Therefore, an override mechanism is needed.

Thanks,
Fuyu


