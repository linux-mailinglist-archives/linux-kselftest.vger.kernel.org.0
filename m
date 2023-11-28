Return-Path: <linux-kselftest+bounces-745-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B245F7FC359
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 19:34:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D54D01C20AB7
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 18:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF0B3D0A0;
	Tue, 28 Nov 2023 18:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="Eq1v8KVq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F397EF4;
	Tue, 28 Nov 2023 10:34:20 -0800 (PST)
Received: from pps.filterd (m0209321.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ASGwqup017030;
	Tue, 28 Nov 2023 18:33:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : mime-version :
 content-type : content-transfer-encoding; s=S1;
 bh=fP+eBjljv5f55nzecO/1ic6Ggh6r5VAFNtORq6zGi9Q=;
 b=Eq1v8KVq62A9QOm4UpyNa2vROfcj8fkq+s1u26bRLM9PWT49PBOILpUtwNaYbziuxwVd
 V6pjX6sDO3vKZmjJvaY8e2CfOOTCVMibbkz03Hnno1/9NDZCe6jDDyOt0mGhB+t+2S3U
 XgJ1UtDuxo80nmKRnlYOXNjdwJ0+oh3il0JDdtiH1UDHPF+ePSkHyNrqrD5HfBPYVIpP
 ua6o9d78p8ynkuev7d8cOkmeBFnuDHkQ4vVGMtyOQNZgpzOS7Ihtt1/YVlgey64TJbqj
 nVdKR6XJemqav+mEvhfANIonVllzAYIxxwi9lpV0vqGL691DpUj41fRGYLlfXpdrC2Ue Kw== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3unm6f82dn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Nov 2023 18:33:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PkPytM6G6wNhk2zqoOCRdfUTw9QUtiUNQoMpCRepTXIUTysOVdsj5IVlLDHBfjblGrVDRwSbiWCEYUH5USiuUNbpn8vyJTdDatCyNzTyqDAeqr+vxlZBolElpROyaQeQl3VHJW6igNsX2nck/jQhUo4deA4l7/h8ebxdwjos5LRGqPGtp/8UuPvGjEHh6TDbxRwJAtuZSzGmdIG1rna09zsmDF2P540CugjJCG632tJKLnIQiTih1VKu6Ot0mcGwS8D08UMb2r+F4k9XEFzp7KQHpZvfS6auyleJosGUT7w5hBClMTcXJJ7wcsoyHvppdh4QSOD91TvT2b5xSMPxtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fP+eBjljv5f55nzecO/1ic6Ggh6r5VAFNtORq6zGi9Q=;
 b=M5hmYoZyHX1Nh+M1oU0gxLhtTeVqZyGkMRAMxpHaVqrKd85XAJeLmiKt0Uh0l2GYkXOvDpYhNDpuEdTasdSpKYeRCFvbDSwrzDEbXXIQNb0qcUKofjE0+p8I3mF6rOHrKGzajgV/y0wKTbIu4GKvDS26U4CfdpNzkiMU5ReLztqXjUGKrIq6fawh3jCqtR7qDHLXq3Uc29XXoykAnorjfZq0M8LB8woTNFsWmVQVdvDD9GSYKqoWA688zQ1u70H9bXAEWj3a3jEJkzPVC+n/IWy1K12zpD9vkWkjVeUh7jMp64lA1bwk8uBfpm3MjRvjm4JbFW0JXVQj/UWzEDy3hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from BN8PR13MB2738.namprd13.prod.outlook.com (2603:10b6:408:8d::28)
 by BY5PR13MB3794.namprd13.prod.outlook.com (2603:10b6:a03:227::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Tue, 28 Nov
 2023 18:33:52 +0000
Received: from BN8PR13MB2738.namprd13.prod.outlook.com
 ([fe80::58b:bf63:b6b:706c]) by BN8PR13MB2738.namprd13.prod.outlook.com
 ([fe80::58b:bf63:b6b:706c%6]) with mapi id 15.20.7025.022; Tue, 28 Nov 2023
 18:33:52 +0000
From: "Bird, Tim" <Tim.Bird@sony.com>
To: Christopher Obbard <chris.obbard@collabora.com>,
        =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
        Shuah
 Khan <shuah@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>
CC: Saravana Kannan <saravanak@google.com>, Rob Herring <robh+dt@kernel.org>,
        "kernelci@lists.linux.dev" <kernelci@lists.linux.dev>,
        David Gow
	<davidgow@google.com>, Guenter Roeck <groeck@chromium.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "kernel@collabora.com" <kernel@collabora.com>,
        Dan Carpenter
	<dan.carpenter@linaro.org>,
        "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>,
        Doug Anderson <dianders@chromium.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH v2 2/2] kselftest: devices: Add sample board file for
 google,spherion
Thread-Topic: [RFC PATCH v2 2/2] kselftest: devices: Add sample board file for
 google,spherion
Thread-Index: AQHaIYqHCCVqMV2IwESZQPAOrwlnnbCQBg2AgAAG6LA=
Date: Tue, 28 Nov 2023 18:33:52 +0000
Message-ID: 
 <BN8PR13MB2738FFDE8693A90B781CCADDFDBCA@BN8PR13MB2738.namprd13.prod.outlook.com>
References: <20231127233558.868365-1-nfraprado@collabora.com>
	 <20231127233558.868365-3-nfraprado@collabora.com>
 <897e404e0097a0c422bdb1d0e2d6cbb996500e8e.camel@collabora.com>
In-Reply-To: <897e404e0097a0c422bdb1d0e2d6cbb996500e8e.camel@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN8PR13MB2738:EE_|BY5PR13MB3794:EE_
x-ms-office365-filtering-correlation-id: d946d10c-b2a0-4519-33ef-08dbf04091f4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 IcwWtxSZ6+dn/bya1bMv+9gCP3pakj4uJADjEjS+CQLkCxPysHnoMY6aDcyyfnHVubYV6AjycKLEuM5X6w6JnM1be6JfouOkcnxoF6s34D6hmdme0fz+I0QrEmIm5nz4HjuphXZkRJVzX+DvuXenGelUkrAjhk555e5+jbaLcluHFf8KHNrsQwkqVWdcckC8AM/8TaI7E32QByf7KdduvdHiIWyeoCVvVXB6L5PysNZlPLHjBhEawKQ9wYEQfpBdVWkVDh1EN+8YuqvUtE8O+xdOdf+K/DsRpnRAAzNHJ/74xszMR/+BEskjQ/KrgelpeUSrifAeCUq6vhv3wtqbBN29EGEtIw0+XESMuDQb8gl796nn7B1X9NiBE6HIYeVPI9czIYWfQ1r6wiKFrLpMguaoUyie33L+pX+yj1TpNLN8caEXWBGil52xKJyfQfmu8/LPFCmXTSveB5h/VD5heSPrPTPX6xsxm291K27SRXMzWcqg99+Ez9oFS7lrZlL5FFXjqsTvaRwhE85y8W8PB7f3VRRPl7Mcb4I0QIGuBlIy0PzGFh8Fq1d8PNk/TJNGWZfA/KCteHq6wJPdKNp0EEItR8Zy6qBN+2IQWLa7/2BYrse6dM+x5ONpB/jSRJiO6bys4L9S86X/F0h2rJlMSl9yAOfylqIqyQUe3uBcin4=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR13MB2738.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(366004)(39860400002)(396003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(41300700001)(38100700002)(4001150100001)(86362001)(33656002)(38070700009)(122000001)(55016003)(83380400001)(5660300002)(82960400001)(7416002)(2906002)(26005)(9686003)(52536014)(7696005)(6506007)(71200400001)(8676002)(4326008)(8936002)(478600001)(66446008)(54906003)(76116006)(110136005)(66476007)(66946007)(64756008)(66556008)(66899024)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?VWxxOURyMHAzbjNpWGgvUmhmcEREL2YreFRoNkxRb2JDUkNiWllOZzhmOXNH?=
 =?utf-8?B?TndSdmtIRFhSeFFqZG83V0NBckhFWHFyTUlpMDVHV3RUeE5vNXp6bkJiMFpP?=
 =?utf-8?B?L3ZNWCtFbzN1R0tGcHowaStZaDVnbmVid3QwY0E4a1lPeU9pemgwN1NxUy9o?=
 =?utf-8?B?T1AycFBlVlFsOUs4NU9ZcjFWQzRjSVJFSGNibnp4eit3L2lZdUFmV2VyM1NZ?=
 =?utf-8?B?ajBjaEt4WUx1VDAyYUtibVRWc2J0UHRrMld5K0c1WENBL3BnRm41NEtrY1Rw?=
 =?utf-8?B?Qkt4NEgyNHdzOXNOOWNPK3Y0N3pCeDl0UlRUaXF5Q0VJRE5WdGsxNHFkWlNa?=
 =?utf-8?B?bEYvSGZaQjBpVWNBamxiN1VQWVMvZ0F5ZEllWGRRdGlMQ1VPSXpQa245TjY2?=
 =?utf-8?B?REJPNzJFWnlhVWVmMGZMVW5hamcraVh5RlRIQ055UHZlUlh1WDRvVGVDMTcw?=
 =?utf-8?B?SXl2dmZRNDUrbFF6SGJhNWNBNnBRR0Jhb2Z1dWZjcmE2OUYwUXBOckZCcEk5?=
 =?utf-8?B?NnR5VFQxMEV1L0FVNTZ6elpibnAyNjRTbDBXSzBEakl0WGVBUS9LUmxwMkNC?=
 =?utf-8?B?cXdVd1IvTi9aQmNiNERmT3R1T3JvbkUzU1Uzd2VLRGFHTnRYczIzOCtucnJV?=
 =?utf-8?B?TzBKTU5TRS9SNUxONDd6Q1dhZUY2NGdnMVNKYlF0bVlhMUhmKzBaRXJoN0lH?=
 =?utf-8?B?dDJOV0lQejA2K1NhRUVBaEx1aG5YZm9nbGlCQlFhUFRuVHNKUW9TQ3YzTTNY?=
 =?utf-8?B?d2UyaEhmNXBMa2xaeUdUUTNxWmVsZUJpak9pV3JBSzJlUTRzREFYTzZIT3Ji?=
 =?utf-8?B?QmFoSXBaeU5EVlJnSHNVK3B0OXdleWtIb2NiSUxYdVkySkdmODhlb3p4WG5G?=
 =?utf-8?B?dzZDRW52SUQvMjdLN1JocHZCZHJKTmNXM25hWXBCbmQzRklJR3Azc0RUR0JO?=
 =?utf-8?B?S3J3d2oyZGxxa0ZlWkdpQnNVeHBxUzhGSmJMTG1YbE5zMUZVQmhrdkRYV09j?=
 =?utf-8?B?SUtneUNJNUp3ZVNERml0M1VIL3BVUVJpL0d0MWZlMnVmUG9FUUlsTHpNb1lw?=
 =?utf-8?B?OVhFRkJtN3ZMSzVUcHNtemUwQ2RSUEtJZ2t1bDJ3UEViTk0vckd4T1lTRWho?=
 =?utf-8?B?OWhBTkFaQmJ5RmZjVVYyVmcxYXk5ZUZmQUJjcnBJS1lEUUNEN0ljcW1Mbmll?=
 =?utf-8?B?YVJnZVJnTm1xaENNMDZDY0JZcDJRV0ZoYndZMzlUQzZKeU4wcmp1UnRydmRM?=
 =?utf-8?B?S0E5SG9aeFlNSjhROWgxRmUyVHg2R04vNGFoUStCdlJlTjdQRlJmV3o0b3Ri?=
 =?utf-8?B?VlljcHBHUmtJeE9JM2orcmhUc08rNjdINkJKMDNubnV0TGx4TTVvU1FqRVov?=
 =?utf-8?B?NWl1S1d5RFRFWUJDMkdGakcvS0ppNUpvU0RCQ3FRZnU1emdEdzdEeDV2dTYv?=
 =?utf-8?B?VW5pYTlKcEoxZGxiWnVscFlVVStCSEFwRW95UVB3Mk0xOXBXa2N3bjVya2cv?=
 =?utf-8?B?ckhHcEhRUVlmem9nTVdKK0VCYTF2TDFSZWFjYnBTNUpQNGtQM2V6aTAwVjBt?=
 =?utf-8?B?bjBHdm9GeVJXTm0vYVcwSDc4UjhCMjh5Sk9WQVB3dXhQdmRXV1VVTXJ1NWNs?=
 =?utf-8?B?Z0JFdEwyOFViZ1ZBQ0JsbzZRaHFRZFdWMm5TWE5JbFFGaENFRElQNjQyWTlH?=
 =?utf-8?B?WEJKUElUMS9SQ3I0NlZ2Q2o2Rk0vVG9BaXB3dzYwN3VuSU1uU3g0LzhBWlJm?=
 =?utf-8?B?WDBIdWg3TjF1MGFwR0FjYlArb0UrR2w3MFU3eFArb0cxbG5xcE8yN2dSTGVo?=
 =?utf-8?B?MWRZWXV6SmwwMzR6MkpIUUZvMmo5NTB2Vk55UGtkSGZ4bFNtUnBDbE9vZVNR?=
 =?utf-8?B?bjVTVkZCckFMa1h0WWFIQjJtT3kyeGJBR0R1SVBCR1FtR2wrR0dHUGt1ek1M?=
 =?utf-8?B?NFpTbVVxa00xbGhHSGljR3dZVG5sWWRRbWlFWVpZZGdvVHNoVTl1T1hBM0gy?=
 =?utf-8?B?M1NqbWxzd2poMEJYa25BK09ZZncxVlM0SmtjVG1nTEhwQXM0clBlR3laZlpV?=
 =?utf-8?B?MkdRcGx1MWNmVWFKVlhPVk9Td08yVno2UFl4WkNhNnk0cFFCWmdIYUl2blAx?=
 =?utf-8?Q?59z0=3D?=
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?utf-8?B?M1BOZENNb0FLcVJiUlpvcjczbkMzZmNMVnljOEY2Q05vR29GOSs4Z29UQi9q?=
 =?utf-8?B?TjRuMDk2bnlZN0tBc002Qng2NVorZXFaZjZkZlhZdmxQSkdUOStMS29NUzNa?=
 =?utf-8?B?TTVtR0E2WjhtTlFjSFRaK3Zud0JpYzRnNVo2SWdQVUFQYTBmTEFWeDZ0bU82?=
 =?utf-8?B?MUhBM0lpKzMvVUpFUGxLTm5XOFlYaThDUUhqN01zcmJ3ZHUwUUtJdzNsUUxP?=
 =?utf-8?B?aExyQm8wbGNUWUpQcUtNb0tJSUFBM3l5V1JmVDBPWmEvODZyRVRoYnp4RXhl?=
 =?utf-8?B?QzdicEQvU1JUV1F6cmFoLzNiZFp1b2FhMXZTYXdhbGJYRlVNd1lIL0ZWZjVL?=
 =?utf-8?B?a01iQVFnVDYyUThxc0k1dDJUNEtWZ2o3bWQyVFI3VDR3WCtIY1RsUGUxTHZx?=
 =?utf-8?B?VC9hUG5tYUk5NCtVM3IrV2JMUm82OG5oRHI3VE4rWDE2TFdMaW9RV0ZZdEdi?=
 =?utf-8?B?dnB1amFnK0RPcFcrODErMGwyUDNMWHNxdHc5ciszM3YxMkVYNVFzOTUyMVg1?=
 =?utf-8?B?THBBRUJFSkFndllGandHR3d3eDV3WjNBVUsrVmliQytyTHpaU3R5TGVJT0hS?=
 =?utf-8?B?eDBMK2ZFOVp2ekNZRU53R3VvSHU0N05uL20yTUcwMkpXUlB6R1hPRWZncXdv?=
 =?utf-8?B?djNyTmdYMkt5TTJ0MEdmWTVvZmVXUjd0NUVDNGFRQVBhVVdGd2ZmOHNIQ2VN?=
 =?utf-8?B?RXU3MTFEMXh4WEh6YjlKeXhFTG94UE14ZCtMRGlFRmh2L1FlaktUQTdQY212?=
 =?utf-8?B?MVRwY0lZYklJV253TFNrY05maHU5L016c2Y4ZE1hMkRyNlNiRlFKY3lNUDV6?=
 =?utf-8?B?VXRNZzZIVUI2emtWNFZrT0ZLc0tTcWFGcWdDVFc2OGg5dmFQZ1J1Qmh4ZS9l?=
 =?utf-8?B?VXR2YTN0NUNoRlFyZDlzeFAxaFRhRWwwLzllK3YxTVJiM0RTdkg5Sk5Oc1pD?=
 =?utf-8?B?RXp3b09Wd09BN2xTbjQrS0ExU3BKOFR2S0toTmlWOWZCWE1JdHBsZlkyUFpz?=
 =?utf-8?B?TnpyTHRGdnJBNi9BejUwNy8zRHJHaml0TGQ2cWxXZ1FsSkEyQ2pmRlM3d01V?=
 =?utf-8?B?V2kxaWVXdnhQZUdzcVBaczhUVGRNZ0J1SkZMamw3SFdZcXJuL1NvR0FXL1JN?=
 =?utf-8?B?Y3NkZFgxOVJHN3Z6b2MwOTBsYVF1MXBINnp5eGpPYlVaay9OWXdKSkk5cHBp?=
 =?utf-8?B?bWhwMmI4WXQzc1ROVVZUb2IyQ3dSVFRkQWdCcFBOdmE4OHBxazkxV0hLM0gy?=
 =?utf-8?B?VFVpUXVOZ3hLUkNHSElMZHZmM3ZRamo0SHhmSDdLTit5YWlqTjVQeERRaklE?=
 =?utf-8?B?UExUL0tXWmliZVBPTU1LNkh2R3I4T0VwQ2h6N1hPeUtISEU4UHlhbXp3RjNz?=
 =?utf-8?Q?13ebQkyfA48jVrM4UnzGfbhFvkHyoqfc=3D?=
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR13MB2738.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d946d10c-b2a0-4519-33ef-08dbf04091f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2023 18:33:52.0275
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nAF+hN2H2JD6ijsrtryymKpgLXtH94V17EBMEbbOOE28cNxyJYzx8hIUYhv73vN/kHH+GmSbIq1zL3k+3xuoDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR13MB3794
X-Proofpoint-ORIG-GUID: dUagdoCWJvyo9RTZNzspgbdWgbEilasU
X-Proofpoint-GUID: dUagdoCWJvyo9RTZNzspgbdWgbEilasU
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Sony-Outbound-GUID: dUagdoCWJvyo9RTZNzspgbdWgbEilasU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-28_21,2023-11-27_01,2023-05-22_02

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQ2hyaXN0b3BoZXIgT2Ji
YXJkIDxjaHJpcy5vYmJhcmRAY29sbGFib3JhLmNvbT4NCj4gSGkgTsOtY29sYXMsDQo+IA0KPiBP
biBNb24sIDIwMjMtMTEtMjcgYXQgMTg6MzQgLTA1MDAsIE7DrWNvbGFzIEYuIFIuIEEuIFByYWRv
IHdyb3RlOg0KPiA+IEFkZCBhIHNhbXBsZSBib2FyZCBmaWxlIGRlc2NyaWJpbmcgdGhlIGZpbGUn
cyBmb3JtYXQgYW5kIHdpdGggdGhlIGxpc3QNCj4gPiBvZiBkZXZpY2VzIGV4cGVjdGVkIHRvIGJl
IHByb2JlZCBvbiB0aGUgZ29vZ2xlLHNwaGVyaW9uIG1hY2hpbmUgYXMgYW4NCj4gPiBleGFtcGxl
Lg0KPiANCj4gRGlkIHlvdSBjb25zaWRlciB1c2luZyBzb21lIG1hY2hpbmUtcmVhZGFibGUgJiBl
eHRlbnNpYmxlIGZvcm1hdCBsaWtlIHlhbWw/DQo+IFN1cmVseSB3ZSBkb24ndCBuZWVkIHRvIGlu
dmVudCB5ZXQtYW5vdGhlciBmaWxlLWZvcm1hdD8gOi0pDQoNCkkgd2VudCBiYWNrIHRvIGV4YW1p
bmUgdGhlIHRlc3QgbW9yZSBjbG9zZWx5LiAgVGhlc2UgYm9hcmQgZmlsZXMgYXJlIGxvYWRlZCB2
aWENCnRoZSBzaGVsbCdzICdzb3VyY2UnIGNvbW1hbmQuDQoNCklmIEknbSByZWFkaW5nIHRoZSB0
ZXN0IGNvcnJlY3RseSwgdGhlIGZvcm1hdCBpcyBtYWNoaW5lLXJlYWRhYmxlIGFuZCBleHRlbnNp
YmxlLCBzaW5jZQ0KaXQncyBhIGZyYWdtZW50IG9mIGEgc2hlbGwgc2NyaXB0LiAgVGhlICd1c2In
IGFuZCAncGNpJyBmaXJzdCBlbnRyaWVzIG9uIHRoZSBsaW5lcyBhcmUNCmFjdHVhbGx5IGZ1bmN0
aW9uIGNhbGxzLCBhbmQgdGhlIG90aGVyIGl0ZW1zIGluIGEgdGVzdCBsaW5lIGFyZSBhcmd1bWVu
dHMuDQoNClNvLCBhcyBhbiBSRkMgLSBob3cgYWJvdXQgY2FsbGluZyB0aGUgYm9hcmQgZmlsZXM6
ICI8Y29tcGF0aWJsZS1zdHJpbmc+LnNoIiB0byBtYWtlIHRoaXMNCmNsZWFyLCBhbmQgbWF5YmUg
YWRkaW5nIGEgY29tbWVudCBhdCB0aGUgdG9wIGFib3V0IHRoZSBuYXR1cmUgb2YgdGhlIGZpbGU/
DQoNClRoZXJlJ3MgcHJvYmFibHkgYSB1c2UgY2FzZSBmb3IgcmVhZGluZyB0aGlzIGZpbGUgbm90
IGluIHRoaXMgb3JpZ2luYWwgc2hlbGwgc2NyaXB0IGNvbnRleHQsDQpzbyBJIHRoaW5rIENocmlz
dG9waGVyJ3MgcG9pbnQgYWJvdXQgYSBtYWNoaW5lLXJlYWRhYmxlIEFORCBlYXNpbHkgaHVtYW4t
cmVhZGFibGUNCmZvcm1hdCBpcyB2YWxpZC4gIFBlcnNvbmFsbHksIEkgZmluZCB0aGlzIGZvcm1h
dCBub3QgdG9vIGJhZCB0byByZWFkIChidXQgdGhlbiBJJ20gYQ0Kc2hlbGwganVua3kuKQ0KDQpJ
IGJlbGlldmUsIE5pY29sYXMsIHRoYXQgeW91IHdlcmUgYWxyZWFkeSBwbGFubmluZyBvbiBwdXR0
aW5nIHNvbWUgY29tbWVudHMgaW4gdGhlDQpmaWxlIHRvIGRlc2NyaWJlIHRoZSBsaW5lIGZvcm1h
dCAoZnVuY3Rpb24gYXJndW1lbnRzPyksIGJhc2VkIG9uIGZlZWRiYWNrIGZyb20gR3JlZyBLSC4N
CklNSE8sIGtub3dpbmcgdGhhdCB0aGUgZm9ybWF0IGFsbG93cyBjb21tZW50cyBpcyB1c2VmdWws
IHNvIGFkZGluZyBhIHNhbXBsZQ0KY29tbWVudCB3b3VsZCBiZSB3ZWxjb21lLg0KICAtLSBUaW0N
Cg0K

