Return-Path: <linux-kselftest+bounces-13687-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD9A92FFC6
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jul 2024 19:28:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70A85285499
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jul 2024 17:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4079117167A;
	Fri, 12 Jul 2024 17:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="QJ+NoBUj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9463917C79;
	Fri, 12 Jul 2024 17:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720805290; cv=fail; b=K6yT+Sj2xxU3C9DFk02UuTdZNYCegvQ1iw4fM095lb73+JYHsvFcmurnpH6bNuxJJB1wCD7e9JAFQZFEuQG7SSRStJuuO4RHfrIpORG2ybraLB1RG/6qEm+3S/l/94JbkPWllc8/HYV4TFn8muQq/SgjDyOLG9EGJ+kDnikbGrI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720805290; c=relaxed/simple;
	bh=TOfrNtJQf+9oJoIyw8M+fTUHmPlqroYjHJuAyJ6im4I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NpgJyzmJBWOK8WguaMcOfknzZpFVxIWhX5uOaKjo5j0eFFPhPcnfP5cU64v1f9Yct2OTnOCjrJGpqgE5KholIw7N/4i4UCtrc0NMEI66GRSWZdT5O0f+05BakYlJ+yssfi3MEWEsEHxf9/KHS3O9B1HC5B3NGKa9tkcp+7D/FBg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=QJ+NoBUj; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46CG6QKb011962;
	Fri, 12 Jul 2024 10:28:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	s2048-2021-q4; bh=TOfrNtJQf+9oJoIyw8M+fTUHmPlqroYjHJuAyJ6im4I=; b=
	QJ+NoBUjjaANTQ/XGPDhEq7aFTdODy7XbC/PO5u4Z2/H6UmNJQysPUmdbEDBqees
	hGLNykynsDBNBKvq4TTVtjhvwrXqC1lQAeXeWQCcJ4sRtgdRm7nunQsNOwwdbcc9
	S/CVZzn3D41XbRphvnq5tb+612sOBpZJc87PGuAXzA5HuiQWcaTGxgRAqPrcfZxN
	t8afhD1NTf0osqayaKWMIDE9LpN6fEpJD07pCP8G8+Tm7DLP+71R5jF1q+3BgbQW
	zcuiBIESV/pOuEcG3A4thDRf8SnaDrPHk0UJRoczV6bTUAC7U9pjb4bQMXxj1Y42
	OKLIMi4+oJISIiLFFzgHDg==
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2042.outbound.protection.outlook.com [104.47.70.42])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 40arfacr1a-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jul 2024 10:28:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K3xwAmvRhNxKKniMaEpP2lxhO2AzAxYCx+O9kAjiksRp1UsObCtf3zOQ9MBuFchM6014wttBk07+/p8B968UikkDKTvFQhMH6Xu8guJb4xgGgk+n6OU63rZiZmYOg645L5p9SLpoIqIrQPmDEdBARy16b5cE3G3Cv4ZYqrxjjbM3Fz9ocS64k3Re/ErAq7Oz96w2w/BaWnNgUHeNxN7/DPDVNKo3FXXSpt62sSf7husmxChCQ5jo+9mViYDEfQ87LeiNp1YIOCRyqTOFfveXO/gf0hO8RXiGa2vL3c7cIVoGFUo5YjjnijEzjdIERV3qEIC1TIsuGVbU+906xW5rvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TOfrNtJQf+9oJoIyw8M+fTUHmPlqroYjHJuAyJ6im4I=;
 b=zJyt4LFiWdc+fG+zRZHQmKpMiZISCkPI9gXaHOBx7f3B2mx37L4maHxKeLWD3N9VvkLBjal88C+5/EHRuT+6Fkudp3flKBgnd+mfLekyknTpxC82sdcyGAWAm/cGIboUbCcDqqD3B0TvMF8IdEmNXZF4MPG2irttv4vw9/fOWk6Oj679VODCFPBbpCGrWDCRF8tXVBcrbXisM0xdgXcYD5IT7RTBN9sbmWFkV+A6RCQg+BS7NflUkSZuzl7bg/TsoKpMvhOeT1x5HGwYo2QaT5RcrYmtvC9A76pyXyaQI7a/mBpwXqF7Dta6DO3vEpSA2ffLrBG4ZvMJH6eLAT2Wcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SJ0PR15MB4615.namprd15.prod.outlook.com (2603:10b6:a03:37c::16)
 by IA1PR15MB6292.namprd15.prod.outlook.com (2603:10b6:208:444::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23; Fri, 12 Jul
 2024 17:28:03 +0000
Received: from SJ0PR15MB4615.namprd15.prod.outlook.com
 ([fe80::657a:1e0b:a042:548a]) by SJ0PR15MB4615.namprd15.prod.outlook.com
 ([fe80::657a:1e0b:a042:548a%7]) with mapi id 15.20.7762.020; Fri, 12 Jul 2024
 17:27:59 +0000
From: Manu Bretelle <chantra@meta.com>
To: Puranjay Mohan <puranjay@kernel.org>,
        Daniel Borkmann
	<daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>
CC: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
        Mykola Lysenko <mykolal@meta.com>, Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
        Yonghong
 Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
        Jiri Olsa
	<jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
        "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Florent Revest <revest@google.com>
Subject: Re: [PATCH bpf] selftests/bpf: DENYLIST.aarch64: Remove fexit_sleep
Thread-Topic: [PATCH bpf] selftests/bpf: DENYLIST.aarch64: Remove fexit_sleep
Thread-Index: 
 AQHazuq1+2PUFsFL2EKpG1WqJaaiDrHs7xQAgAACPYCAAAdNgIAAALQAgAABvgCAAAmFAIAACTyAgAGjroCAABOmjIAC0mEAgAHLvzM=
Date: Fri, 12 Jul 2024 17:27:59 +0000
Message-ID: 
 <SJ0PR15MB4615BF10FDB6D4577AC84D87CBA62@SJ0PR15MB4615.namprd15.prod.outlook.com>
References: <20240705145009.32340-1-puranjay@kernel.org>
 <c0ef7ecf-595b-375a-7785-d7bf50040c6b@iogearbox.net>
 <mb61pjzhwvshc.fsf@kernel.org>
 <CACYkzJ7d_u=aRzbubBypSVhnUSjBQnbZjPuGXhqnMzbp0tJm_g@mail.gmail.com>
 <224eeadb-fc5f-baeb-0808-a4f9916afa3c@iogearbox.net>
 <mb61ped836gn7.fsf@kernel.org>
 <d36b0c2e-fdf2-d3b0-46a8-7936e0eda5a8@iogearbox.net>
 <CACYkzJ5E+3xYkNsH7JoVkjabzSwnZZCzzTz5B50qDB7bLYkmMA@mail.gmail.com>
 <890d23f2-636e-12d1-31cc-eb6469f2a9ac@iogearbox.net>
 <SJ0PR15MB461564D3F7E7A763498CA6A8CBDB2@SJ0PR15MB4615.namprd15.prod.outlook.com>
 <mb61p5xtcyqo5.fsf@kernel.org>
In-Reply-To: <mb61p5xtcyqo5.fsf@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR15MB4615:EE_|IA1PR15MB6292:EE_
x-ms-office365-filtering-correlation-id: 2ddf4388-f8fb-4806-c3a5-08dca297f9fc
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-8859-1?Q?bV9Ngrrcath0BjuOM05yZVQaMhCktyX2mN7sRo8wuDUQ+JReS3o3prcJ2p?=
 =?iso-8859-1?Q?N3AC/rKhJMuVcnXvFmbkZLQX4G3zzHYOORq1UmST5EkH0wMqV0DMZ0+ebz?=
 =?iso-8859-1?Q?u71pIsCCxRgOLP6d2TmdYDtNAYN42ITQMPjcajozyYQAYB7ocRe+11dtrl?=
 =?iso-8859-1?Q?1kvQ7zDUDrDrb0O6MdChVEEE5l3Z1c6pGI5VTOyGkHTGPEQOD8/+h/kXHq?=
 =?iso-8859-1?Q?MMW7hqx4RopWcAo/0qOCgynCK00rDpU5amDNlYao0Z5voFnlyTC0Rn1rwb?=
 =?iso-8859-1?Q?Lx6oCO/9yJ20e6JfhID2Vrb/FGuCwg8F2gTrlPPhv/rxJax8HYbU9lIHS/?=
 =?iso-8859-1?Q?WDNLcJ9YfxLVjHnOGen0zuBMF/cMK3sut8UwZdr1GipG/UZDzhePiTKDnC?=
 =?iso-8859-1?Q?zhwL3qu7Fd1a3D/weSijJwaA5BOmX80/EDnZwTsMxaapz3WJ9JopccocmY?=
 =?iso-8859-1?Q?O6D6E2QwBQ7LcyZdwXYaJlJiCa535+/NmtpIizfF3wOWnNH100mekh7eCd?=
 =?iso-8859-1?Q?LHivMkGIP3DTTRwuDoDnGbfdcXxL+CrVNZZnYm1WR5u80JZwezuejAzY53?=
 =?iso-8859-1?Q?mc+ug+UaC6AxqDYgsRiwShVvJ8kSDPAyy82xEtIwi2uj1n/sLeRCP/GBiO?=
 =?iso-8859-1?Q?J0iWFoPabKvf1+3t1td6ZuGiiSiw+IMUxq8ApLKJyaai1ZFi4bzrHpwc/8?=
 =?iso-8859-1?Q?tzV7YOk72cx75fN2fPwWOje9ot7/tDHQMaUj1aloveOCF/ZFi8nyQcV5Qe?=
 =?iso-8859-1?Q?VpZRg36amqYHK6o7+RUCC1XItoWYH4aXOu+w/RjVHQIjwELoHL2T7cRc5g?=
 =?iso-8859-1?Q?BEn7+LPq7RGMqHlf/Nq1uGjyTyGzcAjpsS4OEVFu8GKF501eYPN/1z/1w6?=
 =?iso-8859-1?Q?ZFiaueDxw27eFbyajSHhYgxzbkdZ11xufQcYA9D+wS3UEDdZWijVv5UfKc?=
 =?iso-8859-1?Q?7hvPIRaArQ0Maf5t3dRP10SSCDEB09hIsAO1pGqPDkpmbQyL+B1rYe66F3?=
 =?iso-8859-1?Q?51itjz3eCQ0i48QE9eYfbGKwC2xn9iix6S5rpBDjrgr9jifaF1je1FMo5U?=
 =?iso-8859-1?Q?OCsbDUn4JBZ1FeQ5NsRqu79JAmfoTnsY56XLkyJmHptlXzOSGDLRmHDOsv?=
 =?iso-8859-1?Q?qq/B4LWi/XptnDhaPyTF/84QUVTXYOFmR1Q3Pxv3K7mhX2CbozzFZE35xs?=
 =?iso-8859-1?Q?MrCH8eHFnR6HqT9phrb1HaT4oOTa0kC6hhpD0rvK/2Wdvjy9e/HYP+S4BP?=
 =?iso-8859-1?Q?FLoogJlLmuzCbUrK+UBBdyjJFd8LmPS+X6b0REOIhtm8q3eiD1ApcJL9qS?=
 =?iso-8859-1?Q?7k1VxsBrd74IF3gmyrDPftbHNbde/ikDmYYKXHRFw1Yj1c0BdpEFDBuoaS?=
 =?iso-8859-1?Q?kSTbb8TgAIFB7jCQbSCKb9IsdzYvf1rZQwfXgeB2jsCPn3B3pzCZU=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB4615.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?/8Zi7CNHa3LjKiONhKApPf3WcD3amlGdohqq/GD4DBOMuqaJFr2W1iQjed?=
 =?iso-8859-1?Q?oiVOHXD+HvsXrRgYZgwKtggDNjnQwoKS2kdu5BR1L9gNP30wz5pVhhHaYw?=
 =?iso-8859-1?Q?lt7Zn0CiOsaULay8gjkuuXbOJjubnlkyOZ0QiP5xEz30HpWX1eCjt6gdTc?=
 =?iso-8859-1?Q?rzwJ1t2D4urKEjsRGyg4dM3ykNygFXUVHg5bV12mCAOUR4mkcJV+v3ojQU?=
 =?iso-8859-1?Q?3LDi6MIu/7emfNfJaZrYlG4xaE4ADxs/0UQVZygPaLqbfRKnCf+iJswydq?=
 =?iso-8859-1?Q?td8ng78NcgBszLjkA0FBPJsWaNSkOf3ZOk6QOaaEBEuPpawMNv7SZ0ddAF?=
 =?iso-8859-1?Q?/z+pxK1vyN2ZJntUmepnv/BY3xMUWh3JQ5OKceV0WIj3TvpE59eq7n7UAW?=
 =?iso-8859-1?Q?T/yl/UlL4WZIQK9ExjoHxmUVsXu1BCrC1aTv/waW554mwwj9tJpLqsu5zl?=
 =?iso-8859-1?Q?uhPGICRRouOR0+qNPYWQHCgIhmdwcUUbY+Wl6zzwyUTUydV8TXLMXaBJ5C?=
 =?iso-8859-1?Q?DjWMN36qx45jl3sH9lPUccTINBQq/9EkDsVL9wDFdtycnVwRhnU+Rco99U?=
 =?iso-8859-1?Q?sWsivjDK3Ja7xWjEe3Ym1uUIEcvnzIZHDMnHHgB+6E3lBYUCNIZruTseLL?=
 =?iso-8859-1?Q?bN8VN6pv/ct18/xK9FAkJMmw0ndt5LQdYdXPvgFmjSDAqYNHLTC/AJJRWj?=
 =?iso-8859-1?Q?ZJUfVGXOk1+/BJyb3ceV+I9BjMg5bjGiHlS1KrWBirkcz5vnLJPA1R2UKs?=
 =?iso-8859-1?Q?lw10GMdnBFyglf8f1l3gyixM8KqyIfRSXLFwlP4wvAJoBgPEa+JG/DZPCT?=
 =?iso-8859-1?Q?qmn6PqNNVuHet5Q58kXUDCf1pNUZjlR2Sif1nOxz1NODGMTSXoyoUichc5?=
 =?iso-8859-1?Q?U2cznftObZh9+KcspIwEB5qQiKLAMReFFYLEW+0H796RdI4VVyVkUX+vVu?=
 =?iso-8859-1?Q?6UfFRVNNzKNH0rly/w2d9q3H/Rgj3wbY7AaCA+gfVsFhMjbtrohDYkDKIc?=
 =?iso-8859-1?Q?GOJ8KZLxAVril3plI1I1b2/XTB2ErrNh+KOyPCyNCqfhD2VjSkAX19x9ri?=
 =?iso-8859-1?Q?FZtMi/ZA/za1QSfFEz4AptS30ZWzeqGTqlLnW8MgAQtPnVPivBxrVd5vHG?=
 =?iso-8859-1?Q?XEVBe8fUJgvCeLSlIcX8DRD0tWqovEstTll6R+0MB0gz4HjajeRT987Wuz?=
 =?iso-8859-1?Q?O5bu8ni7gt95NsBEhVN21W9sA2eK5aHAwo9G5+XUJQNO6IrbMpDSZUNGII?=
 =?iso-8859-1?Q?oYAPxNmcCiKWLV8IY5yV310Fs5ka+OBFMo7c3kROZdI2W82OvfISI1yHl+?=
 =?iso-8859-1?Q?5FvTPSElCSbYTywTm7u8VOJGzFIOWuRP9Z93BfdmV/do4dl/+86OOCFx8B?=
 =?iso-8859-1?Q?91+4J61MYUAoha3MMAwggwFC2uzEZP/Lz9nBC70ByQ6igo7GI0aXaw4SQ9?=
 =?iso-8859-1?Q?ritXbqJ6f3klyBZAFrodcyr2s0quE1I6oI8u/duGPAAYSSpe6zg6Znpj2Z?=
 =?iso-8859-1?Q?1OCqndpQjIxUVLTSUPfQRMsXXnPM3yd839QJapxMqwEbNNv26Pb9bjA+Ax?=
 =?iso-8859-1?Q?knPV0KLiB8KYqr6S6JBES+34BWB3iW6jtu+rA6ZGQi/uQ/dcpicGvatnLc?=
 =?iso-8859-1?Q?PlV1IgtACfa+Gc4j+4htPzjxNBNZPDbvSaqRY/xDA1E3cRuYsZ2+KCsw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB4615.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ddf4388-f8fb-4806-c3a5-08dca297f9fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2024 17:27:59.7209
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XGtXzl5HtYjFgESK8DvLiaXtsbN96TDSjWiHuJw0gY8G3mGGRFkEleP7Ai2+PtdxQpn+cfxUOwvxFXplY5bEzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR15MB6292
X-Proofpoint-GUID: i4iJMVmc_29Us3ikw_lnAWBrsvvJtOZ3
X-Proofpoint-ORIG-GUID: i4iJMVmc_29Us3ikw_lnAWBrsvvJtOZ3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-12_13,2024-07-11_01,2024-05-17_01

=0A=
=0A=
=0A=
=0A=
=0A=
________________________________________=0A=
From:=A0Puranjay Mohan=0A=
Sent:=A0Thursday, July 11, 2024 7:00 AM=0A=
To:=A0Manu Bretelle; Daniel Borkmann; KP Singh=0A=
Cc:=A0Andrii Nakryiko; Eduard Zingerman; Mykola Lysenko; Alexei Starovoitov=
; Martin KaFai Lau; Song Liu; Yonghong Song; John Fastabend; Stanislav Fomi=
chev; Hao Luo; Jiri Olsa; Shuah Khan; bpf@vger.kernel.org; linux-kselftest@=
vger.kernel.org; linux-kernel@vger.kernel.org; Florent Revest=0A=
Subject:=A0Re: [PATCH bpf] selftests/bpf: DENYLIST.aarch64: Remove fexit_sl=
eep=0A=
=0A=
=0A=
=0A=
=0A=
Hi,=0A=
=0A=
I was able find the root cause of this bug and will send a fix soon!=0A=
=0A=
=0A=
=0A=
> Unable to handle kernel paging request at virtual address ffff0000c2a80e6=
8=0A=
=0A=
I was able to confirm the fix using the artifacts from https://github.com/k=
ernel-patches/bpf/actions/runs/9905842936=0A=
Thanks=0A=
=0A=
=0A=
Manu=

