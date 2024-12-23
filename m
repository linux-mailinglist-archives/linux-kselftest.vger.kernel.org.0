Return-Path: <linux-kselftest+bounces-23728-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B939FA8CA
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Dec 2024 01:59:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 044621885173
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Dec 2024 00:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DDE7539A;
	Mon, 23 Dec 2024 00:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="NW4VTpwq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from esa11.fujitsucc.c3s2.iphmx.com (esa11.fujitsucc.c3s2.iphmx.com [216.71.156.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CD32107;
	Mon, 23 Dec 2024 00:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.156.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734915533; cv=fail; b=rPSBjmJpfvieAP4TqCydUKzbGU/Cvv66Ur1+efwmL5FsGpN2nU7MupzyvNLzB0xDtcYRpt4gWMLafZXp27FmbiO6xyyuHT8KQHzj1lv06y3/p1f6YohyQ3XurTs7L/ubvg3r8pIo7TLtgVhSlDKLHPcSigf2FlXEtsRSvCxz8YE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734915533; c=relaxed/simple;
	bh=nZiY+TLfbNS6cmHcNNOAojFndpuVUAheC+n7LDlbKA4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=R0CKHKeHNRO7DGwMDtDX3aGVMHU5WTLY9j7gI9+3xoIhCQ90f6IF1kuSj06VAPskZpinyYnsr9dm7QAAtffCZ4cPg9ooagBvf1KvWB/IReGhyS/M1y+SfM9z/sbbCpiTKgFPALj4R/nu86VTIBDeIyheZK2VObDTEtBckG8x+B0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=NW4VTpwq; arc=fail smtp.client-ip=216.71.156.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1734915530; x=1766451530;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=nZiY+TLfbNS6cmHcNNOAojFndpuVUAheC+n7LDlbKA4=;
  b=NW4VTpwqLE8v9kexpAfG1Nu9HOk35eYZshG1XEeDQjcO5dPZxmhPFdkB
   B96NqIZu9A6LIjKZJOwUZeRf5XKxujYVuy3eAoePq6kt10I1x5J36qiOD
   MM7B7hr/OQyBePzuQbs2crKrPQRFBGnL2mD2ZMQajWlJDzysrXf8jyE/0
   9TI6Bi8yRbgNGdx9UU/ZXcDmim/bcS93/7Naltub6MxOAVfEQhWs/9FkZ
   kqMjXZIcM9YhjQLVy8euJeUCTCApkpmalW15NkvK5SbWORsjub1LSfKBf
   1KMBBi9iEQxt8ewzTj5AbBcFSu/u8ZY/1r5fxqLilzEX/9B4hO4gH13jw
   Q==;
X-CSE-ConnectionGUID: FXA7eI/fT3a3X5tVnFLyFA==
X-CSE-MsgGUID: aapdEScHSw+K+4PH485GWA==
X-IronPort-AV: E=McAfee;i="6700,10204,11294"; a="141889892"
X-IronPort-AV: E=Sophos;i="6.12,256,1728918000"; 
   d="scan'208";a="141889892"
Received: from mail-japaneastazlp17011028.outbound.protection.outlook.com (HELO TYVP286CU001.outbound.protection.outlook.com) ([40.93.73.28])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2024 09:57:36 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gYVVTT6OIWJN6d/GXwJxWK1c2YG8ZC/WJOlfzQe9HRTTLZNYHcYAB0DsEckdxko2vnFv0p1WfFfTjGVT8OO2nHxOPo3FJsaRiLXl19Hq/sF3RzAvV4/KaekjPwpScsLJPUqb7d807GLoKn0i413r65hyzUJLdr9qBjp2fe4dEz0vGQYrU5cyyYaacqa92fcIM+QWcUcAZVXYibCndgae/sGN9sP58hHmgJkQl6azjp+Z5ZMlX+PLTqCJpM5XqiNEjjv0yXBAxZo2jHOv7Stf0RHhz5OGUg0T8P4yso3ko+WNrfB3aidQEkgM7vfoNrH1KFsGjE4sCEDCYQ/QJ3MSoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nZiY+TLfbNS6cmHcNNOAojFndpuVUAheC+n7LDlbKA4=;
 b=uin813QgWOmwFmwgdr/614kVBOZTwXSHD4SMfYf+OMBSy6vDnHweJvrTFkQbCBFaBLYmG2jIA4Zt38CjlizQaylZ6N0z4GHWQk3xX0DHOMdvqf29JigCke1QyZK+rls4ylcJb46fzGxLS18cdj5xC81JnH8A8Pe2wIGutCcm/MQx+SuyfwcKT6/OPQKe0a8U6l3BESyXbe56ZPg1Z3kC618YGMjCVUHUSYTfbpyWhowf5/WQVAB4S6ZEfp4VU696j9jQSUtPGqiOMZVYCQ1S3oF72OHNZALCYHA1e1XIFfo145WRf98OIxo/uGEXzIlezNGfVOZgW8q+AQQppLnlMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by OSCPR01MB12851.jpnprd01.prod.outlook.com (2603:1096:604:33a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.20; Mon, 23 Dec
 2024 00:57:34 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377%4]) with mapi id 15.20.8272.013; Mon, 23 Dec 2024
 00:57:33 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Masahiro Yamada <masahiroy@kernel.org>
CC: "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>, Nathan
 Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH RFC] Makefile: Export absolute srctree path for
 out-of-tree builds
Thread-Topic: [PATCH RFC] Makefile: Export absolute srctree path for
 out-of-tree builds
Thread-Index: AQHbUDE2YluD9d5UZ0aU7JIvatAtCbLwFASAgAL244A=
Date: Mon, 23 Dec 2024 00:57:33 +0000
Message-ID: <ac440eb3-0115-4b2f-b8c6-976ef925460a@fujitsu.com>
References: <20241217031052.69744-1-lizhijian@fujitsu.com>
 <CAK7LNAS4yrEvvDOFdHyNxBp9Yzi9=eGRsO+2R-t+NNTOfp=gHg@mail.gmail.com>
In-Reply-To:
 <CAK7LNAS4yrEvvDOFdHyNxBp9Yzi9=eGRsO+2R-t+NNTOfp=gHg@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|OSCPR01MB12851:EE_
x-ms-office365-filtering-correlation-id: 840b3aae-65af-417f-ca18-08dd22ecc92e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|1580799027|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?SHQzVWFIZ0IvMkJlc3VDRGV5Skt5ZXluQklUb2M0d2M4Ym5yMklXSmcreTdG?=
 =?utf-8?B?ZU5HZytHV2NnclAvQytQNnBHYVpRVWtsVFlhdC9DT3pjTTZYT0FqVGdKdGoy?=
 =?utf-8?B?L1ZpMkh2c0pVM1RHQzdHNFVXTGxDUEtDV2dyUlJpWUVLeDBZYWVZYlllUHVq?=
 =?utf-8?B?SWlzMldGYzJYTnVuQ1FSN01Kem9hZDM3QXhOKzZabGpwdFE1K3o5b3RBMWhz?=
 =?utf-8?B?cVp6QnpESDBuRUNMZTYxcU94WCtUdnhnejlFUjByQnowcGpMN2RuNHAzS3J1?=
 =?utf-8?B?RTUzQm9FZ0NjZnUrYjd5QTJGWlhPRWc0OXFwc2RSOUJveHNwODBUUGx6NEc4?=
 =?utf-8?B?ZTE2cjk2NGx6ckErdHh3MHUxYmczS0QwUEtmNktZL3FwOWdBSW9zWHJHNnFS?=
 =?utf-8?B?VHhYaWx3d0k5My9DcWlCNC9lSTRzbWVlZXVacEpQNGo4UHpEalZzWjZlSXZi?=
 =?utf-8?B?aE0xemF1ZmpwSFNJTHE3RHpXZVZFWCtMUDYwUWVKNTUwc0dWNG1RT3VsVDJ2?=
 =?utf-8?B?Y2NjVFRSRnZNTW1OUTBua3ZpdU5UdkRwQUNFSm00RzVMUjFTbC9IWkJHWXBM?=
 =?utf-8?B?M1dZVGl5TEtycXBuWHo2RHhlcjFFdGpXUGYrVTZsQlRRaFpmSjBtL3dMb3Za?=
 =?utf-8?B?L3JpV3ZGRE03U1A0Y1RiMDJFUjI4cWVuOFhCaHRVUEl6ZEFOR0dyUXM2Y1hO?=
 =?utf-8?B?YXFkQ2pJRHBIZ01reDN4VGNja2ZZZlh0b3lxalhuZW1CYjBaQzR1U1BmaTVm?=
 =?utf-8?B?MzkrM0tnL0ZjTWdYWFplVUNPYkxPSEcyVHFVWTRiUk9OekZFYVU3L3Z5dFVF?=
 =?utf-8?B?ZmorTktBUGcvV3p2Z01IejdxZUxPQkFPNFlzdnQyVjYvcjFWd25FUjh2Ulg2?=
 =?utf-8?B?S2h5b01pejdBMkRmVWoxVGE3dnV4M1A0VytNZEhTNldHNVBGbmFCTnhYeEVi?=
 =?utf-8?B?OEh6c0QyejB1UlhnUkZBWVRIcC9IMHh1UEpXMnVzR2c0NGRxV24ya3lyUHVS?=
 =?utf-8?B?L0JJY3J1cWJ6S1VpUXB5c3Q2TmRiUEZQRDdLekYzMExqNmtqYlNKb1BKQk5Y?=
 =?utf-8?B?ZVlxcVIxdlNCbTlYWEg2bEMyK29LZjdBZGNSTkkyRjNBcnhCdW1iWjdpMlpQ?=
 =?utf-8?B?TVk5a3h1WkEwV3MxWU5Sa2RYREpVQkRkK1BZVjcxNFVsdW5leW9uc0g4Yjdj?=
 =?utf-8?B?RkQwdHFrRFJDY3VGYjBYRkRLR1hWdUVRS0dPR083UUw5akJrbzFsaUlvbzNM?=
 =?utf-8?B?STNyVnpwcnczcmZ3RjRqRENJekgvWnBWdm1WRjJDWkdiUi9CRjEzVmIybzYy?=
 =?utf-8?B?U1FlbjBZeHJYQ2RZZ0UrQll5TDlITkx0U1NxdE9wVjllQnVwMzE5RTNpV2FS?=
 =?utf-8?B?V2JHN3k3WWdMUDk2SHFOa1g3YXJJNGVjcXp5aFdQUno1WUdwVXAzdEpUcWNB?=
 =?utf-8?B?RTVTVFh3QTV4V09udU1OWkpoVWtRV3dGNEsraFpScXF2T1pWWlpubFhPTyt4?=
 =?utf-8?B?UzJENXprczB1bW9ZbEY2SGd2N1l4VUFmYVhOTFBQdGYyelpoeU9hV2UrUWhY?=
 =?utf-8?B?YjQyKzVPb0ZtVnc4cFgrRTUwS09PandvT0xqS0lXcmlKbmVoSnRoY01WVGdh?=
 =?utf-8?B?aVhveFA5bW1Sdm1BZVF5akpZTk1qVGRwYTRXQUtHSkREQ29oYTk3K2dScWhE?=
 =?utf-8?B?ampnZGdhL0g4L01PbnVPNUZqREhnZExkM1VXbVhvMC9CNmVJOS81Z2cvbHp1?=
 =?utf-8?B?SzVpbEZqN0RKaUVIck5nTmM0L3VKRGdrbENJOWJWM2tnT3F5QVVJUlNTRDJJ?=
 =?utf-8?B?QlZGNENqZjByOWhJZGM5R2VkME1FbTl6ZlZzS2tydElWTDlCMkRid2o0WlFo?=
 =?utf-8?B?VDFvaWpNQUxCdzlRUWJhcVV0a0tqUHZHWFN0emZ0WGs2dVQ0SnBXU0wwQzVq?=
 =?utf-8?B?aGx3NjRPbzNYNGlvdXlyZkRicklNcUp6OUptWHJwSk5lUCtmQldmOFAva016?=
 =?utf-8?B?cmlReDl0N2hBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(1580799027)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ak1zMG92Z1Y1N2Zvdmd3RWlBUlVCenk1U0Y4bXJ0aU5vT2ZkeFJRdmhTUjVO?=
 =?utf-8?B?T3preGZnMUozcFExUnB1WFVMTHNmR3VWbnlyL0JlejdDN1p2T1JuTkZsQWNh?=
 =?utf-8?B?ZGMvY3ltbFpVbCt2bGwzTVUzZVFDeklSZy9sdTV1d21KYi9ib0RqN2NvN0U1?=
 =?utf-8?B?T1d1MW9Va2g3aUh5ZjdYREhzS0Y0YmJ5N0hqejQ4VHV6eUpONEFIajFlZVND?=
 =?utf-8?B?TW8yRGx5NjJKYy9TaTBBWVlRQWxzUXg4WWNnaG4wWmQ3YTZ1amx0SHJoZGk0?=
 =?utf-8?B?YzVWNkhFZFEyK2tTRFhHMjZaVjQvRE54enBubkMxTnFQTG12YXVldFp4RE5K?=
 =?utf-8?B?QTZMc1NXWERnVnp3VW1LcjY1dXdOQTYvQkkyVnNRL0RXNW5hdFlUT251VkNS?=
 =?utf-8?B?WDQzQlpXbHE3RXRDa0RpZ1JuMnlnQ0dNM21aRDFyb3VaNEVuVlMydDR1YlU5?=
 =?utf-8?B?eEw2bHpPeWhWMFB4QmJTUDFTcHVGSmt1dkRCQm41T3czSjNQOUwvNGRlNWVJ?=
 =?utf-8?B?MHl2NjJ0bFVlV2dLOTVCa2wwUGl2blZFc2lVSW4rZlhBalB2SmFiK0EvYklJ?=
 =?utf-8?B?RGRLYVhzUHVjMXBqYXI4YWl4cDRpYnZNMWNmKzJKT0ptSWpjSGFCKzJpNlRC?=
 =?utf-8?B?MnBrbHRkajZXOEtQUHUvUFkyT2ZEdzhzQ0srQ0FJWU9vd1NOYkpCNHlxSi9P?=
 =?utf-8?B?Y0VobWpXSkdycy8wdGtvRktTYVZ3VGtRZCs4SWorQTFBYVlPT1Q3NDl1YlZq?=
 =?utf-8?B?MitGYzQ2MlRDbnBQVFBveHZwL2Z0c09pcjhNQ0lpdDl2dDhJY3VGcEtjU3FY?=
 =?utf-8?B?aStib2Q3VVFjUWNYZlNoU0l2QlBSZnZiZ2w1UlA1L2Rld3cwckxhaWFScFJH?=
 =?utf-8?B?REdESGNpWFRGYVdSejRmSG1QaHBvdk9LanhVb1RyU2NZNlV4UkVhWmVFTVIr?=
 =?utf-8?B?Qk11YThFbWpwY2Q3U1hIMmplN1JtbnBxd1AwTkk3Y1FvbElqa1VwUDUvb1Ux?=
 =?utf-8?B?SXQxeEYzdHRxN0ZCTUlYNHZwRnQ2Y0NaQUhBcXRzNGFWQnVhUWd3UW8yOTUr?=
 =?utf-8?B?eW03SldhOXcrdGM0MS9pdzEyaVN0eUNhOXVkUmtPeU5yOW9ZMTQyTDZPUXNI?=
 =?utf-8?B?bkcyMGJEcFRCS2t2WGNRMUphZmRmY2REUHIxc1lhVEtYNG9LNWdTUUdnSDBC?=
 =?utf-8?B?Z2laV1pmc1plYzh5TktMblVXblRTQXQyd0RKcUJRclNCU2Vvcys4eHY1dWl4?=
 =?utf-8?B?Z0JydXRlK0c5NHZJdXUra21NcnpvbVdId05BSi9LeCtpNmlnYWQvMnAyeXJ2?=
 =?utf-8?B?KzY0dzlmMWhGQzU5RHR6R3QwYm9QcFlKYzJheVBhQUoyVDJsTlZmVk5oaUoz?=
 =?utf-8?B?NXdXRC80NXVFcjI2VTFmZW9wSUVNSUxSWjlaMUVtR1RkbDJRQzFOTHZpMzBD?=
 =?utf-8?B?QmswU2h6R2YvRjN3VmIrblJJUHJEQm1hejBKb1Mxa0FPbC94K2FyVjdDaUdP?=
 =?utf-8?B?RS9jYk0wTjBpbW1NaitlRURvZlZjeE5JM0diNW1ocjlWNDRpOEJKMjB1Vzh3?=
 =?utf-8?B?UysxSXJkSXRkd1dUWnkrcHFEOXFXRGoxcW1JYTZpWXFOV0xQWEpMUEM2L0gv?=
 =?utf-8?B?WnFRMXBXeEZkNjY2eHhTTk4rRnpVYUpQbTI0YnZ2ejkybHA2alJpQ0ZxVHF3?=
 =?utf-8?B?UlVXRVh6blVZdFcwV0FPeUkyQmZRTzJjTzRjbmJXMHp0L1lUTnB1ODdaYVNq?=
 =?utf-8?B?UW83bzFnZW96eDNwc1NwQTN2bkF4OHF3Y2dxVGd1ZlZYMHBrVTh0a1ppWXJp?=
 =?utf-8?B?eUJhKzNUVjVaeFE3Wll2Q2Y0S3oza2pYbGczbDFEcnd1eno1UVVDL0xyczFM?=
 =?utf-8?B?d210RFBVU05wa0trY3JoUitGQ2FqeG5wR21SSzZuQ1Fsa2RKaW9teDhKYXNo?=
 =?utf-8?B?cGNzWS9ESEVjUWlKWU1uVGJ6NStGRVNsVEV1eW8wU2UwUmQxRG04ZUhTbTA2?=
 =?utf-8?B?b21IU1FWNUtsdERjVU5CSHc4ZGRBQWRJbERFOXZXbmxkRXZWTDFFbjVyQ3Bm?=
 =?utf-8?B?a1h2QTl1VktGZ1ZhS2hoQjdtMW5IczlLWXY4bnJCaGtmZ1lhTndVcTBYQy9B?=
 =?utf-8?B?OHJVdDR3dHNiUFhwUEYwc3BUd2ExYXR0MjhJc2swOXdQVVRtQU9sck1BS2dr?=
 =?utf-8?B?b3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8B480CE85AD47E49873908FEEBE42737@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	E0aYVKsXmJLwhVObuigbh+UaDTWWMQ2+m6ftSTZ3SqmKy7fk+ZklDNlTvhsUD9JlGblQKKwqMU8xTkbpMsUnEuoiigtLjn9D7XtbJg3WrFUnGKPbH6pDF0y/WCkruiB/SJKdN8sBM/UEFObUYDASH6zg2ntoDPAwcQ3n00AkEyfRfiC8EHQ0xYnwXp3rSWb0FrT8Z0LLj5x/JkW6YuicOZF0cIrTp+9PKC508g8eXh1xTt87qUtO7QBTY9oalm9dezpzTvtH/dKCukrVTujVTDTg9BmLn91vogpDKaTwGB7Lk796IWSpaNXdT+lhQLiulJf/Z+VD4+UGKHh3qrs+nyKwKPtpQrjRdzvT01q3/hWPRcWR6CJPO8DSBOYELZ3reGd7cJkzoU0kFG1qAH7J0a7+TLkBvu6JnZtfbiHhUbpU3gW5CrfQRnpbxh3cR6zL0QXQutGKW4ZEIeVtVkVfa6h8zD8/J7urHCUKtuyIwFAG0/COqvQ9oV6liahkHNqT/3S4zfJUGHhcwY6jNFd4grnC4dAci1T2LjYFd4IOiBl89GogrCkrlpLN93+wJUD+rppFhehxlvX0g3GFZNZxGM9tDSbgalrG/8On0rIvUkRlZP5ovuHkbPWWQj6XZIIB
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 840b3aae-65af-417f-ca18-08dd22ecc92e
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2024 00:57:33.9138
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F5ZQu27ySzW8Ce2E8floQ/TOl6Ysf23d4sMyCB0rhq/XCT+z4/3+win7KcHZcDWPvFEd58Xa+QFKyavcp80KlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB12851

DQoNCk9uIDIxLzEyLzIwMjQgMTE6NDEsIE1hc2FoaXJvIFlhbWFkYSB3cm90ZToNCj4gT24gVHVl
LCBEZWMgMTcsIDIwMjQgYXQgMTI6MTDigK9QTSBMaSBaaGlqaWFuIDxsaXpoaWppYW5AZnVqaXRz
dS5jb20+IHdyb3RlOg0KPj4NCj4+IEZpeGVzIGFuIGlzc3VlIHdoZXJlIG91dC1vZi10cmVlIGtz
ZWxmdGVzdCBidWlsZHMgZmFpbCB3aGVuIGJ1aWxkaW5nDQo+PiB0aGUgQlBGIGFuZCBicGZ0b29s
cyBjb21wb25lbnRzLiBUaGUgZmFpbHVyZSBvY2N1cnMgYmVjYXVzZSB0aGUgdG9wLWxldmVsDQo+
PiBNYWtlZmlsZSBwYXNzZXMgYSByZWxhdGl2ZSBzcmN0cmVlIHBhdGggKCcuLicpIHRvIGl0cyBz
dWItTWFrZWZpbGVzLCB3aGljaA0KPj4gbGVhZHMgdG8gZXJyb3JzIGluIGxvY2F0aW5nIG5lY2Vz
c2FyeSBmaWxlcy4NCj4+DQo+PiBGb3IgZXhhbXBsZSwgdGhlIGZvbGxvd2luZyBlcnJvciBpcyBl
bmNvdW50ZXJlZDoNCj4+DQo+PiBgYGANCj4+ICQgbWFrZSBWPTEgTz0kYnVpbGQvIFRBUkdFVFM9
aGlkIGtzZWxmdGVzdC1hbGwNCj4+IC4uLg0KPj4gbWFrZSAtQyAuLi90b29scy90ZXN0aW5nL3Nl
bGZ0ZXN0cyBhbGwNCj4+IG1ha2VbNF06IEVudGVyaW5nIGRpcmVjdG9yeSAnL3BhdGgvdG8vbGlu
dXgvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvaGlkJw0KPj4gbWFrZSAgLUMgL3BhdGgvdG8vbGlu
dXgvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvLi4vLi4vLi4vdG9vbHMvbGliL2JwZiBPVVRQVVQ9
L3BhdGgvdG8vbGludXgvTy9rc2VsZnRlc3QvaGlkL3Rvb2xzL2J1aWxkL2xpYmJwZi8gXA0KPj4g
ICAgICAgICAgICAgIEVYVFJBX0NGTEFHUz0nLWcgLU8wJyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgXA0KPj4gICAgICAgICAgICAgIERFU1RESVI9L3BhdGgvdG8vbGludXgv
Ty9rc2VsZnRlc3QvaGlkL3Rvb2xzIHByZWZpeD0gYWxsIGluc3RhbGxfaGVhZGVycw0KPj4gbWFr
ZVs1XTogRW50ZXJpbmcgZGlyZWN0b3J5ICcvcGF0aC90by9saW51eC90b29scy9saWIvYnBmJw0K
Pj4gLi4uDQo+PiBtYWtlWzVdOiBFbnRlcmluZyBkaXJlY3RvcnkgJy9wYXRoL3RvL2xpbnV4L3Rv
b2xzL2JwZi9icGZ0b29sJw0KPj4gTWFrZWZpbGU6MTI3OiAuLi90b29scy9idWlsZC9NYWtlZmls
ZS5mZWF0dXJlOiBObyBzdWNoIGZpbGUgb3IgZGlyZWN0b3J5DQo+PiBtYWtlWzVdOiAqKiogTm8g
cnVsZSB0byBtYWtlIHRhcmdldCAnLi4vdG9vbHMvYnVpbGQvTWFrZWZpbGUuZmVhdHVyZScuICBT
dG9wLg0KPj4gYGBgDQo+Pg0KPj4gVG8gcmVzb2x2ZSB0aGlzLCB0aGUgc3JjdHJlZSBpcyBleHBv
cnRlZCBhcyBhbiBhYnNvbHV0ZSBwYXRoIChhYnNfc3JjdHJlZSkNCj4+IHdoZW4gcGVyZm9ybWlu
ZyBhbiBvdXQtb2YtdHJlZSBidWlsZC4gVGhpcyBlbnN1cmVzIHRoYXQgYWxsIHN1Yi1NYWtlZmls
ZXMNCj4+IGhhdmUgdGhlIGNvcnJlY3QgcGF0aCB0byB0aGUgc291cmNlIHRyZWUsIHByZXZlbnRp
bmcgZGlyZWN0b3J5IHJlc29sdXRpb24NCj4+IGVycm9ycy4NCj4gDQo+IE5BQ0suDQo+IFRoaXMg
bmVnYXRlcyA5ZGEwNzYzYmRkODI1NzJiZTI0M2ZjZjUxNjE3MzRmMTE1Njg5NjBmDQo+IA0KPiBU
aGlzIGlzIGEgcmVjdXJyaW5nIHRvcGljIFsxXSBiZWNhdXNlIGtzZWxmdGVzdCBhZG9wdHMgYSBj
b21wbGV0ZWx5DQo+IGRpZmZlcmVudCBidWlsZCBzeXN0ZW0uDQo+IElmIGtzZWxmdGVzdCBjYW5u
b3QgZG8gdGhpcyBjb3JyZWN0bHksIHBsZWFzZSBkbyBub3QgaG9vayBpdCB0byB0aGUNCj4gdG9w
LU1ha2VmaWxlLg0KPiANCg0KSGkgTWFzYWhpcm8sDQoNClRoYW5rIHlvdSBmb3IgeW91ciBmZWVk
YmFjaw0KSSB1bmRlcnN0YW5kIGFuZCBhZ3JlZSB3aXRoIHlvdXIgcG9pbnRzLCB0aGFua3MgYWdh
aW4gZm9yIHRoZXNlIGluZm9ybWF0aW9uLg0KDQoNCj4gWzFdIGh0dHBzOi8vbG9yZS5rZXJuZWwu
b3JnL2xpbnV4LWtidWlsZC9jb3Zlci4xNjU3NjE0MTI3LmdpdC5ndWlsbGF1bWUudHVja2VyQGNv
bGxhYm9yYS5jb20vDQo+IA0KPiANCj4gDQo+PiBTaWduZWQtb2ZmLWJ5OiBMaSBaaGlqaWFuIDxs
aXpoaWppYW5AZnVqaXRzdS5jb20+DQo+PiAtLS0NCj4+IFJlcXVlc3QgZm9yIEFkZGl0aW9uYWwg
VGVzdGluZw0KPj4NCj4+IFdlIHdlbGNvbWUgYWxsIGNvbnRyaWJ1dG9ycyBhbmQgQ0kgc3lzdGVt
cyB0byB0ZXN0IHRoaXMgY2hhbmdlIHRob3JvdWdobHkuDQo+IA0KPiBUaGlzIGlzIE5BQ0tlZC4g
SSByZWNvbW1lbmQgbm90IHdhc3RpbmcgQ0kgc3lzdGVtIHJlc291cmNlcy4NCg0KDQpJdCBzb3Vu
ZHMgcmVhc29uYWJsZS4NCkl0IG1ha2VzIHNlbnNlIHRvIGF2b2lkIHVzaW5nIENJIHJlc291cmNl
cyBvbiB0aGlzIHBhdGNoIGdpdmVuIHRoZSBjdXJyZW50IGNpcmN1bXN0YW5jZXMuDQoNCg0KVGhh
bmtzDQpaaGlqaWFuDQoNCj4gDQo+IA0KPiANCj4gDQo+IA0KPiANCj4+IEluIHRoZW9yeSwgdGhp
cyBjaGFuZ2Ugc2hvdWxkIG5vdCBhZmZlY3QgaW4tdHJlZSBidWlsZHMuIEhvd2V2ZXIsIHRvIGVu
c3VyZQ0KPj4gc3RhYmlsaXR5IGFuZCBjb21wYXRpYmlsaXR5LCB3ZSBlbmNvdXJhZ2UgdGVzdGlu
ZyBhY3Jvc3MgZGlmZmVyZW50DQo+PiBjb25maWd1cmF0aW9ucy4NCj4+DQo+PiBXaGF0IGhhcyBi
ZWVuIHRlc3RlZD8NCj4+IC0gb3V0LW9mLXRyZWUga2VybmVsIGJ1aWxkDQo+PiAtIG91dC1vZi10
cmVlIGtzZWxmdGVzdC1hbGwNCj4+IC0tLQ0KPj4gICBNYWtlZmlsZSB8IDMgKystDQo+PiAgIDEg
ZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4+DQo+PiBkaWZm
IC0tZ2l0IGEvTWFrZWZpbGUgYi9NYWtlZmlsZQ0KPj4gaW5kZXggZTViOGE4ODMyYzBjLi4zNmU2
NTgwNmJiNWUgMTAwNjQ0DQo+PiAtLS0gYS9NYWtlZmlsZQ0KPj4gKysrIGIvTWFrZWZpbGUNCj4+
IEBAIC0yNzUsNyArMjc1LDggQEAgZWxzZSBpZmVxICgkKHNyY3Jvb3QpLywkKGRpciAkKENVUkRJ
UikpKQ0KPj4gICAgICAgc3Jjcm9vdCA6PSAuLg0KPj4gICBlbmRpZg0KPj4NCj4+IC1leHBvcnQg
c3JjdHJlZSA6PSAkKGlmICQoS0JVSUxEX0VYVE1PRCksJChhYnNfc3JjdHJlZSksJChzcmNyb290
KSkNCj4+ICtzcmN0cmVlIDo9ICQoaWYgJChLQlVJTERfRVhUTU9EKSwkKGFic19zcmN0cmVlKSwk
KHNyY3Jvb3QpKQ0KPj4gK2V4cG9ydCBzcmN0cmVlIDo9ICQoaWYgJChidWlsZGluZ19vdXRfb2Zf
c3JjdHJlZSksJChhYnNfc3JjdHJlZSksJChzcmN0cmVlKSkNCj4+DQo+PiAgIGlmZGVmIGJ1aWxk
aW5nX291dF9vZl9zcmN0cmVlDQo+PiAgIGV4cG9ydCBWUEFUSCA6PSAkKHNyY3Jvb3QpDQo+PiAt
LQ0KPj4gMi40NC4wDQo+Pg0KPj4NCj4gDQo+IA==

