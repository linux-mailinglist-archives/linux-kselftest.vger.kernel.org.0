Return-Path: <linux-kselftest+bounces-17216-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D15596D6B7
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 13:06:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75464B252AB
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 11:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B72199222;
	Thu,  5 Sep 2024 11:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="gPNWjAKk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2053.outbound.protection.outlook.com [40.107.255.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00E1197A95;
	Thu,  5 Sep 2024 11:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725534404; cv=fail; b=rvlgCQ731RaDNSBoR/LCQjmuFitNnw1r2P6iMqC/+zxEF7lA4oWDMzhYEMfTjm45NOXHkQaDbqf5y+8AdVQ/SrU1yDCd+n73y7t7WFZTwAT1QS0dYPqHg4dt6o2Rcs8PKHs3hj/GzT2xsZL2++NPZ3HrEdZRyJNQRpm0eFllgzE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725534404; c=relaxed/simple;
	bh=HvpZwKwLJzGxWdlIr4bYn3E1/Q12W6UXhnH8S3eFvR8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rTriIVZOStjVu7YWsazhmOwBvvKDxAeF9wmejm83M6y0n+Fg777wps4c30Im2xIOhIVkTpIvO55hRH+6NiVoDDWKtg2j7TqEb3PpXBo5XjGB4cbfNF6RVLz9XIRNuUm+ip+lYjWk6geQR8TevdjJGwG6/yUVszkcEXFzdMsp4Ws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=gPNWjAKk; arc=fail smtp.client-ip=40.107.255.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XETSWqR2Fzj4lkZibpyJYiMmnbAhAEy4zU30a2XMaDI45+sKzcHtxvbkZuLe3yOUO2kbXX4bLxsmqpp0+U4nV08B0PMMH6wSdOqZ4X21rdrA0MjsPQEG8jRv8kSFBvxMXcwsQ5KMgQWC4aknV7kSLJEph9kOPS7oF/S09r2o5L7G4HSKt6ESFH9RHVKEVe2CUVlsGduAOP5zcURFxZD4y4eNN2omHwXGKBoJ5khQT53/M7El5y5hZ/7jJVAbbuucxtOfjpirzFF6Sy8NsHBmQ1YLAHYfHEiucEzRGEX+PQEIqttdN5eoe9YX02FRzrNVmuj9F3f5CPwcrBfXX/Yirg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PzUbx1KVVm0b3MYO9GzKxITsdXor8K6vEl3Ddou33l8=;
 b=VQysI3vW3srbVcRHp0a9FYzWAJfc3IxUdguk/f5ou9aY/hhu75PW6SzO8xR8m3SlF0bzGDMNst4q0tzGJWkt4iFLzgZ5h0ob8RjnQdQNzHm1slHqy0u+4o+8ln9uMhdwoR9z7ddWeOwB3oj78IwOfauhYCE5DI9QSGR8+aZ/BkUahXxIETFNhCd1wLjIFQT1eJGYYHot1ZQ19h0jvf1rKeOdiCbrJ9ouYw8qFOWtfY37oF4GyVyGLT/C9UaZtYPBahyOjykc1M+hjW4JhFMWfCecF0FqDGUrr+XgqzuBF2wOLEiJXQ7Sf4jDKi01y8t+eM0iUIgVaaLkASJrYilBag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PzUbx1KVVm0b3MYO9GzKxITsdXor8K6vEl3Ddou33l8=;
 b=gPNWjAKk4MCqDkxU+G0NrdIi4q12lmC8Gy3NrbWwHGadA/03VxHr7GX9dqLAkL74AFAw+GuPx2V90BELIfx/dBmcJ4OgiTWNi9HZFPrJznXRetGpZHQne5rY9uj9dfjnqWf/weW3wvJW/lIgyPb3XmQWn1kTaxpGKymytLym6b883Q7uHF5nYbIqP3RoxDx+nnT83hlY5S4wV+fjfbsPzjpBhhSLf1OlUkjALLzGjhRwFsyhRGCXC079NoM2+4kEmv1IOlnYB08m0KiapQR/5qXrJA8VfdtGzCkuGosdG0arFlQvjdFLu1I0CE+w8lTUYYZWspXMlIivisfiQbzZMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR0601MB4324.apcprd06.prod.outlook.com (2603:1096:820:73::6)
 by SEZPR06MB6138.apcprd06.prod.outlook.com (2603:1096:101:eb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.28; Thu, 5 Sep
 2024 11:06:35 +0000
Received: from KL1PR0601MB4324.apcprd06.prod.outlook.com
 ([fe80::f8ee:b41e:af25:202]) by KL1PR0601MB4324.apcprd06.prod.outlook.com
 ([fe80::f8ee:b41e:af25:202%7]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 11:06:35 +0000
From: Lin Yikai <yikai.lin@vivo.com>
To: bpf@vger.kernel.org
Cc: opensource.kernel@vivo.com,
	yikai.lin@vivo.com,
	Quentin Monnet <qmo@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Rameez Rehman <rameezrehman408@hotmail.com>,
	Kui-Feng Lee <thinker.li@gmail.com>,
	Alan Maguire <alan.maguire@oracle.com>,
	Yuran Pereira <yuran.pereira@hotmail.com>,
	Jordan Rome <linux@jordanrome.com>,
	Chuyi Zhou <zhouchuyi@bytedance.com>,
	Dave Marchevsky <davemarchevsky@fb.com>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Tony Ambardar <tony.ambardar@gmail.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Abhishek Chauhan <quic_abchauha@quicinc.com>,
	Geliang Tang <geliang@kernel.org>,
	Hou Tao <houtao1@huawei.com>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	"Jose E. Marchesi" <jose.marchesi@oracle.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	David Vernet <void@manifault.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH bpf-next v1 3/3] libbpf: fix some typos in libbpf
Date: Thu,  5 Sep 2024 19:03:07 +0800
Message-Id: <20240905110354.3274546-3-yikai.lin@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240905110354.3274546-1-yikai.lin@vivo.com>
References: <20240905110354.3274546-1-yikai.lin@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0036.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::22) To KL1PR0601MB4324.apcprd06.prod.outlook.com
 (2603:1096:820:73::6)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR0601MB4324:EE_|SEZPR06MB6138:EE_
X-MS-Office365-Filtering-Correlation-Id: 83eab1fe-24f4-4aa6-fbec-08dccd9ace67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZmpkK05JZEhmK0wxUzdKUUZKMWRTaXBNUXNTYnRKWnUzbWoxMWlFNTBoWnJV?=
 =?utf-8?B?b3ROdjJJbGFNM2U3ZUJpZm83TlRPU0t6V1VEc3dmR0dNa2NKTWptT2IxZnB3?=
 =?utf-8?B?VVViblBvcm1nZTZKbFFvTGZqVnRSLzRCMjcrNmxlS2dhZUdFRjI1VFc5K3U4?=
 =?utf-8?B?WGpzZUhoQXB6dkQ0UDNteDZlMGx6UVpGV2pFdGdSdkcxbnF6NjRUbEE1SzNa?=
 =?utf-8?B?Y2Z0bnVFbkZvQ2szUUp3VmpodlJjVitCUVdmWCtDY084a2xtMlJMYXRpelUv?=
 =?utf-8?B?bmp3KysyMTlDN0E0T3hYa3h6TW0zeGVwTzdJaWhaT3lNTUdJWUZ4YWRtK1VN?=
 =?utf-8?B?b1lPSTRYc1hZV0JZNi9RaXhac29YdlBHOUdPa0RSeXMzTzEvam91WnhNWUcy?=
 =?utf-8?B?c1pDR0tJSEY0RStEbVNrRmVRSDMwaEdlSkdaWXBGc25ReW5yeDYwOVlYc0JT?=
 =?utf-8?B?VEtJTVJlK0tSYVBIRkRrSzJTOW9CZkZZOEJMRDVhalVlc3RqRURoWDAxY2Vm?=
 =?utf-8?B?SWw4VGw5dkVocDU3OVpISHpxL1FzcU8ySW9odXU1cVhaN2MvRmd0YU5CUGt0?=
 =?utf-8?B?U21yR0UzdkpXQjNIVGRGdVkvT05HdHVPbit3L1JxNFhHSGZwalJ1K0dITzZN?=
 =?utf-8?B?MmhKdEJjMGJuL3JFcS9qME53bURNNklMUktGb01xQTBNRUtIckwrd2tPSXpD?=
 =?utf-8?B?cmJRbThYT1pqazlmTXVUbi93YmdoOCtpSVhJMzZPM0ZweGxmb3B2TDFCSGhW?=
 =?utf-8?B?RFpRaUZXOUU2SXlYd1lUbDlkV1dXVXo5UnFBQjJZR1VnTm84blp5ODFzMita?=
 =?utf-8?B?QUhYdzBZa1k1Wm9XYjJ1UFhYY2ZmcVRRdlVwcU4wVmhCQXp5Zzl0Qm9ZTDIr?=
 =?utf-8?B?RHdRSC9DWVdGU3VYakwwdm1KZGdGR3lhU28zZHFLdGM1ZkIxWWFSSFFVWUlU?=
 =?utf-8?B?VGNWdUgzMmY4ZC9lK3Q2aWdkMTlsc3FCSmFDNnNwak92aDJhQXBJekhzMWdj?=
 =?utf-8?B?ZjA3MDJmYWt5YXpscTNCM0ZFakdnMWhPbTVXTVBMNXFYWUpRUS83Y0JkSXIy?=
 =?utf-8?B?aFRNV0UzN3B3Y2ZtNTNCUklsT1Z3dUg2VGNEZW84ZFVVczVzem5ZbktiQnBi?=
 =?utf-8?B?VHZEYTNHWTNWcit4Y2pyZncxdDdXVXdxcWVFMTd3Mk1BL0FDWWtJUVppeGdI?=
 =?utf-8?B?N1FwNTVlL3JBeE9ZZlBHd09JZWh3Q2VZdGJOdnM0bWt3WUhIcnhvSlJvMHB2?=
 =?utf-8?B?aXpqck0zK2ltVHd5bUF3cGhJN1EyZm9qb1dIeVJwZGhJTVpjZGU5UDBSQ0tP?=
 =?utf-8?B?WjFFWW9USHlncEVGdGhIZDNudm11TzFHRWRMdXFwaFJET3FMNW0wdk8zL1ZZ?=
 =?utf-8?B?R3d5d1B5amVjWkhiaU50b3QyTkVoelFidElUTnRJNFhQTm5MWDJGdzZHSSti?=
 =?utf-8?B?MDhXemNUS2FYS3VGWFU2dmYwSkRQcGNlOW9hVGV5cFAxeXlVQW1FSEZzWGpY?=
 =?utf-8?B?OFpHdGFHbTZMT2toWEY5ak5VTDQxd2JPYWxqWTlRZHJrSk51bjZON01FTjUx?=
 =?utf-8?B?bWwyZk9qQnkxOU5UYTRqdkc4eWt4cDUzT3hjanhPTkx3cTNWZTlkSmhCby9C?=
 =?utf-8?B?WC8vT3VISjlqTXNnZTJ3TGV4eXBFd25zZS9YVExRT2JMVHhJdnZsWHI0TmhB?=
 =?utf-8?B?WVBWeTdTUXkwNUIwUktvaDUrN010dGFKNEEvcmpmR0dwVE0xdTh4NzBaK2k3?=
 =?utf-8?B?UjRaMjRacEg3V3JneHpMcVJ1bnV5MllEZFJ2K3ZCN24za3l4RjVVdnhzTTJX?=
 =?utf-8?B?WGFoeGRTZ01NQnhueUVFbXByMnpiUDJtQjZlQ1dUYmZsTSsxRXZPSzZqMmti?=
 =?utf-8?B?Q3J0Rno0WUQ4OU5KVnJoVzlVNTFUeTV3THBzNys5b2lQOHc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0601MB4324.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eUt4OUtvejJMVktFYlR5ZGE1TjJvUzRNVXN2QkFaYTc1c3dFN0ZUNVdjc2h0?=
 =?utf-8?B?cG85MnlhdzFQRGh5M0J3UW1CRXhkUXMyR212ek1BcWxsRXVHUzI0Qk5waENV?=
 =?utf-8?B?N2RiZDUvQmliYnd4WlZxVHo2T3BIUldLd0VjV0hNSVB0NHRDeHdkblRWOTlC?=
 =?utf-8?B?SWJrZWdMTmNvTzM5ZUlWSlFPaG5lYU16V1YvTjhaSlZQdWJJWWd5U3Z2aFdK?=
 =?utf-8?B?UVJicWpNNmcxSjJWMmRxemZlb1hhMDk0WTFrUm1wTnNrU0wwYkJGaCtDS1pw?=
 =?utf-8?B?cEtzRHB0WnAra1lqY0kxUERJejl3U053MzJBVGE0QVo1UG1FWkVXQjVoOXRr?=
 =?utf-8?B?R1hacW9GNk5UcUY2V0t2d1BJSGo5V25UUXV2RkxYWW40L3VYN3IvUTJyUER6?=
 =?utf-8?B?czlBb2NSdGgwVWdSdmZMZE1PR2lLTFNqZmwwN3drdkpLbTdXaEkyMUZJdFFt?=
 =?utf-8?B?RkFPV053Y1ppeHljNlIvdm1LOFZEY251b2ZqM1hjMzhjbzd0NmpSRStubEVF?=
 =?utf-8?B?MlZzVXZjUldqOEVScmM3TkVybW1yRERVWXNuaGZhaURtaTNocitNZkFxTnp0?=
 =?utf-8?B?dzM4UTlEOXlHY0pSaVBqUkJqT0tjbVVKdENUOFhMWXZvREx4RzZZRmJtdERR?=
 =?utf-8?B?S2c3L3daRGcwL3NRSVRBQkIrUE9FaDdKaVZXalVNc3ZQRkxhR1hvME1wbXlZ?=
 =?utf-8?B?TmlBejA5dzcxNENFdmN6QXhzeFVGSGs0L2YxblB0TURLOUJrMUkwWjdQbGZW?=
 =?utf-8?B?aXYwOFRhMnFXWU91STMwdTZPMTc4akJMSVo2VDFNY0ZOcDFNWk1hWHVZYVBB?=
 =?utf-8?B?WE9SbGdlbWRzSFVaWjNiTzZOQjJ4eXI5YTBqMFlTR2UzV25kQUc0elk1MlJZ?=
 =?utf-8?B?Z2VXcWJDYXBYTmVJVlRQcUp3U1g1dXl4RlpkazZkdVY1SkNLaGpLWEhvK2lO?=
 =?utf-8?B?TGNtZkt5bVZSdkYxZG05aTJNeVNUajEzdG10b1pXR3Y2dmYvWTA2U0lnZ2ZM?=
 =?utf-8?B?WUttT1ZqQm8ybU1nOVJDZE9QTmxKUm9DS0hqMkNqeENrWDZscTliVVdDUnVs?=
 =?utf-8?B?cEYrWTZaMEdzdnVvbmxPblJTSmVsK1ZwS2FLdWJtaXVuSmR2MjVlRTRwS0hi?=
 =?utf-8?B?aXNJK3VKQ24wZkpZOXNpYWFMSzlvdnNDeUdoU2JybWQ1Q3N3L0RLelZnVTFI?=
 =?utf-8?B?QzcrZWgrMW82NUtaNVBvckM4bUdvbHIybVV0eUVEWVFzaWNHMWZGRjJjTi85?=
 =?utf-8?B?MG51OEZUcnNpejBpUHJzTFFUM2RrL3V1dC9iam1IZndxYXlTYit4S3QzU1RI?=
 =?utf-8?B?T2EyMk1PdktGc2ZNMU5ZUFZ5NWJPNU5SdlVIRzBHaGlIVlJHTjlOYkppZEdE?=
 =?utf-8?B?K3BVYkR5MnRkT2hjWXBIcXViQVhDVWhpdENNSW5KeEEvUCtSakUrTUxvS1Uy?=
 =?utf-8?B?cDRqYVBYdnFENVdPMmdHSzlSRTFrUjIzc3Z4bEh1dG14RlNLcm44REozOWRl?=
 =?utf-8?B?dXI4YldnbVphRHZGL2gxbmxVRmQ5dFY4L0lIdVNzMDNYQ3JOZkswei9rdGRJ?=
 =?utf-8?B?WGNnMjNDa2VoNXo5RnVZZDl2cmw3aC9GVFdtZFNONUVCdC93azFoTzN1Qnk0?=
 =?utf-8?B?ZVRtZXcwZzlwVEVUdzlYVjZ3S2JBc2YvMnBENzl1bnpnR1lLZEpLbFRHNFBt?=
 =?utf-8?B?MjBsaDlUWEllSExnQ3dVL3lIZUUwb0ZoYitJR3R0TjdDTzJGWEI2MnE0R1dI?=
 =?utf-8?B?ZU9YVmw2TjJGa0REbVdUbDN4U3E3b0RrYWZ2VDNibUxRb29VcFhYaW11N0lB?=
 =?utf-8?B?amhlQzdtRVQrWFNIWE5XV1oyaitwMXphaDVlMlR6R09QZk90VnRJMEc1dzh1?=
 =?utf-8?B?RW9XYlMrTk9lM1JOMyt5QmNoVXZCaEdqTHRPeUZ6YURqZy9sQkhucGFKQnZC?=
 =?utf-8?B?M2dhUVFQYVJnUGdOb2RCYWMvZlZvSEFSa2FsREhiWlhzVDhFQWtWQVNZclB1?=
 =?utf-8?B?UzVDMlh4M3JoanRPeUdCU0QwWXBZQnhmc1RuOFQ4KzR4TVBoSEsxaUhOa2Vu?=
 =?utf-8?B?cDVrK3ZHMGw3SndxWFNNSE5uRnFpd09hSlFHSjJmRnBadGdrV2p0S1lSOXhs?=
 =?utf-8?Q?BZvtvPqZ+5sn0dKXIRqAqwcgR?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83eab1fe-24f4-4aa6-fbec-08dccd9ace67
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB4324.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 11:06:35.3027
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wr+T0H57P++6c1f4OLwWmuFPV4fJ7gjD0gJHMSBY3+3MQj1tBeHeuSdpsVUgD71v2XElz14Pm7Q/Es8TsVWNpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6138

Hi, fix some spelling errors in libbpf, the details are as follows:

-in the code comments:
	termintaing->terminating
	architecutre->architecture
	requring->requiring
	recored->recoded
	sanitise->sanities
	allowd->allowed
	abover->above
	see bpf_udst_arg()->see bpf_usdt_arg()

Signed-off-by: Lin Yikai <yikai.lin@vivo.com>
---
 tools/lib/bpf/bpf.h         | 4 ++--
 tools/lib/bpf/bpf_tracing.h | 4 ++--
 tools/lib/bpf/btf.c         | 2 +-
 tools/lib/bpf/libbpf.c      | 2 +-
 tools/lib/bpf/linker.c      | 4 ++--
 tools/lib/bpf/usdt.bpf.h    | 2 +-
 6 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index 972e17ec0c09..a4a7b1ad1b63 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -100,7 +100,7 @@ struct bpf_prog_load_opts {
 	__u32 log_level;
 	__u32 log_size;
 	char *log_buf;
-	/* output: actual total log contents size (including termintaing zero).
+	/* output: actual total log contents size (including terminating zero).
 	 * It could be both larger than original log_size (if log was
 	 * truncated), or smaller (if log buffer wasn't filled completely).
 	 * If kernel doesn't support this feature, log_size is left unchanged.
@@ -129,7 +129,7 @@ struct bpf_btf_load_opts {
 	char *log_buf;
 	__u32 log_level;
 	__u32 log_size;
-	/* output: actual total log contents size (including termintaing zero).
+	/* output: actual total log contents size (including terminating zero).
 	 * It could be both larger than original log_size (if log was
 	 * truncated), or smaller (if log buffer wasn't filled completely).
 	 * If kernel doesn't support this feature, log_size is left unchanged.
diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
index 9314fa95f04e..9e45291e40ee 100644
--- a/tools/lib/bpf/bpf_tracing.h
+++ b/tools/lib/bpf/bpf_tracing.h
@@ -473,7 +473,7 @@ struct pt_regs;
 #endif
 /*
  * Similarly, syscall-specific conventions might differ between function call
- * conventions within each architecutre. All supported architectures pass
+ * conventions within each architecture. All supported architectures pass
  * either 6 or 7 syscall arguments in registers.
  *
  * See syscall(2) manpage for succinct table with information on each arch.
@@ -651,7 +651,7 @@ struct pt_regs;
  * BPF_PROG is a convenience wrapper for generic tp_btf/fentry/fexit and
  * similar kinds of BPF programs, that accept input arguments as a single
  * pointer to untyped u64 array, where each u64 can actually be a typed
- * pointer or integer of different size. Instead of requring user to write
+ * pointer or integer of different size. Instead of requiring user to write
  * manual casts and work with array elements by index, BPF_PROG macro
  * allows user to declare a list of named and typed input arguments in the
  * same syntax as for normal C function. All the casting is hidden and
diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 40aae244e35f..8d51e73d55a8 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -4192,7 +4192,7 @@ static bool btf_dedup_identical_structs(struct btf_dedup *d, __u32 id1, __u32 id
  * and canonical graphs are not compatible structurally, whole graphs are
  * incompatible. If types are structurally equivalent (i.e., all information
  * except referenced type IDs is exactly the same), a mapping from `canon_id` to
- * a `cand_id` is recored in hypothetical mapping (`btf_dedup->hypot_map`).
+ * a `cand_id` is recoded in hypothetical mapping (`btf_dedup->hypot_map`).
  * If a type references other types, then those referenced types are checked
  * for equivalence recursively.
  *
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index d3a542649e6b..27ad3c6ee868 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -1848,7 +1848,7 @@ static char *internal_map_name(struct bpf_object *obj, const char *real_name)
 	snprintf(map_name, sizeof(map_name), "%.*s%.*s", pfx_len, obj->name,
 		 sfx_len, real_name);
 
-	/* sanitise map name to characters allowed by kernel */
+	/* sanities map name to characters allowed by kernel */
 	for (p = map_name; *p && p < map_name + sizeof(map_name); p++)
 		if (!isalnum(*p) && *p != '_' && *p != '.')
 			*p = '_';
diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
index 9cd3d4109788..e0005c6ade88 100644
--- a/tools/lib/bpf/linker.c
+++ b/tools/lib/bpf/linker.c
@@ -1413,7 +1413,7 @@ static bool glob_sym_btf_matches(const char *sym_name, bool exact,
 		return true;
 	case BTF_KIND_PTR:
 		/* just validate overall shape of the referenced type, so no
-		 * contents comparison for struct/union, and allowd fwd vs
+		 * contents comparison for struct/union, and allowed fwd vs
 		 * struct/union
 		 */
 		exact = false;
@@ -1962,7 +1962,7 @@ static int linker_append_elf_sym(struct bpf_linker *linker, struct src_obj *obj,
 
 		/* If existing symbol is a strong resolved symbol, bail out,
 		 * because we lost resolution battle have nothing to
-		 * contribute. We already checked abover that there is no
+		 * contribute. We already checked above that there is no
 		 * strong-strong conflict. We also already tightened binding
 		 * and visibility, so nothing else to contribute at that point.
 		 */
diff --git a/tools/lib/bpf/usdt.bpf.h b/tools/lib/bpf/usdt.bpf.h
index 76359bcdc94a..b811f754939f 100644
--- a/tools/lib/bpf/usdt.bpf.h
+++ b/tools/lib/bpf/usdt.bpf.h
@@ -39,7 +39,7 @@ enum __bpf_usdt_arg_type {
 struct __bpf_usdt_arg_spec {
 	/* u64 scalar interpreted depending on arg_type, see below */
 	__u64 val_off;
-	/* arg location case, see bpf_udst_arg() for details */
+	/* arg location case, see bpf_usdt_arg() for details */
 	enum __bpf_usdt_arg_type arg_type;
 	/* offset of referenced register within struct pt_regs */
 	short reg_off;
-- 
2.34.1


