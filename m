Return-Path: <linux-kselftest+bounces-18181-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D49F097D973
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Sep 2024 19:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0123B1C21585
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Sep 2024 17:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD74C381C4;
	Fri, 20 Sep 2024 17:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YmQaHggE";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jwG77ISH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C0CEBE
	for <linux-kselftest@vger.kernel.org>; Fri, 20 Sep 2024 17:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726854773; cv=fail; b=hRRcyBtig4d9NVPJ/kshZ7AK8SrzE65ZJCuCk8ESGaV3yOkGHMAV3o+pnVb9Bvj7tWRSiGM5R7dPVr4hKszmZ56KUOLs44kaXWyrb3LOqmwa7trLbKSPIFlCQfz+Ye9KRr/7S16BOimYlv0a+cI+MMQUr+4eGSKaMvMz3NaK26Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726854773; c=relaxed/simple;
	bh=xVfmHttXX6vvpkx838hmJyg8QbNzAHlsmcyOhNjphgM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZRZ7/gNeCZcnTq4ZKFKqorB43Ig3Q2HN0atEpbT738rHP35ab5m68rM4Ch9NQn3lVuyY7aT8WyY7ATOgaQRNZcnZFFvJPry3Kh0JsOwH50UxAEjf70kTJkg9+YLj/7RixI6AnwfYYFzcHxZZFMYTr1XVLEekS0jTposgRR7u8Vo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YmQaHggE; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jwG77ISH; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48KGfZDi000485;
	Fri, 20 Sep 2024 17:52:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=xVfmHttXX6vvpkx838hmJyg8QbNzAHlsmcyOhNjph
	gM=; b=YmQaHggE+0DvN0vMh+FJP7VsWdXshRmxPlN40BAHdlFT1hRFZm7BbT/88
	JytLs3oPyG4y0eQKKWvlxc/mfUILYmJ+OZlnQEPppo2HFu/zVswe6IbamA6A9zAC
	Gkthp3i8+7BA9FE0QvTb3+tAcIlumVED5yV8QA8WgDzTF5mIU3UEUEWOL1759kVT
	XVYSPq4P8JMc5Pjh+24B+S1jGWI9eIwGwRXLlOiaig0X/pWtGTrdJV9x94RA1rLq
	UPw7Sr+ZlWnG5KmOOz1H8MJ0NVetAI51G6WpCDKzDpDEKwiCzasF9O6Un5nP12PW
	EBmZIA21s+n3VwPnRB2e6Xua78xQw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41n3nfydqs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Sep 2024 17:52:40 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48KGwAmp008137;
	Fri, 20 Sep 2024 17:52:39 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41nyfgg6j4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Sep 2024 17:52:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=egZpZdwbs//2p8Z7OHxXyhSdK+qMmQU2krKZmXKxIAxMoqvL6tjnp9S3wLp0fcKryKc5K/sPZFIIiL6gE+pmCRbWUvXsAW9FmqzPVvUjsCUUXT7DYA/haVKFs74HFdj8JVxWfOGWIw48OF8nsYNTQaEH8cT5gZ+KY20kdwC5VZmY7hqzjS9iRqDME9DImZFF9FsDW+/07BUplvaWBBq0w91Qgvtjfj2px+IBSE/S/e1XZFX6GbXrOZXPgfSIDmFmRa02M+jJNbUSGWsk9F6elrv79AnCkIHGEwtBTIA1LnEO9dRsWprw9ghsf7YJhPEAOx641Hn1KHdGhqn7Evv0oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xVfmHttXX6vvpkx838hmJyg8QbNzAHlsmcyOhNjphgM=;
 b=kgB9EZA63ssM59IaOqnQ+iMvykzTCAg0CZrHOKJeN2qRuvrQesLSIyY1sVT9aWedxVCDv7mGtoTYHjYrrZfw76x10fpL9Xnf96dsTaa4IQHskwj46NmJytOZFC8r0eyrF4pM6GaQ6uwKcs7Ou7zyMryx3F5Zn4H+ce37268kvNOouNN0iDbd+JiatZUUs6uyjMy3mzAUmgD7kVUvbe+lDvW+EA1i1H49Y4HIvhEqxOAcin2JikACane+HrAyY40BJLUuP0qqZH8hPGtAH0eds61Pk40jrGWuQ6VT6WC+RPOGg6gRHs0UuaU/9bX01H1Ksffybkndg5/raCleGj57XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xVfmHttXX6vvpkx838hmJyg8QbNzAHlsmcyOhNjphgM=;
 b=jwG77ISHQar2SSacSNl23w8QcxEO/uVxC0blbkicndtx0Qm3tsOEsGudD6yKAOEd6yC6aCV4psswKnOndQblrn9EoPsn2sl4KhO0pR8vv3sjhtKRtXgWZGLI4jsjyKJT9WgTr+HbboZ/hYsK13vt8i5KMHpTJQTBZyQC9kE67bM=
Received: from SA1PR10MB7634.namprd10.prod.outlook.com (2603:10b6:806:38a::17)
 by SJ0PR10MB5693.namprd10.prod.outlook.com (2603:10b6:a03:3ec::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.10; Fri, 20 Sep
 2024 17:52:21 +0000
Received: from SA1PR10MB7634.namprd10.prod.outlook.com
 ([fe80::5d7d:6585:d28f:3d9b]) by SA1PR10MB7634.namprd10.prod.outlook.com
 ([fe80::5d7d:6585:d28f:3d9b%5]) with mapi id 15.20.7982.012; Fri, 20 Sep 2024
 17:52:21 +0000
From: Yifei Liu <yifei.l.liu@oracle.com>
To: Shuah Khan <skhan@linuxfoundation.org>
CC: "shuah@kernel.org" <shuah@kernel.org>,
        "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>,
        Ramanan Govindarajan
	<ramanan.govindarajan@oracle.com>,
        Sinadin Shan <sinadin.shan@oracle.com>
Subject: Re: [External] : Re: [PATCH v6.11 v5.15 v5.4 v4.19 1/1] selftests:
 breakpoints: use time passed to check if suspend succeed
Thread-Topic: [External] : Re: [PATCH v6.11 v5.15 v5.4 v4.19 1/1] selftests:
 breakpoints: use time passed to check if suspend succeed
Thread-Index: AQHbCVPEQLti3BwH2UaJUde74H2DlbJfcxqAgABMJACAAQvcgIAALeAA
Date: Fri, 20 Sep 2024 17:52:21 +0000
Message-ID: <C8B50D46-3294-4B3A-B731-3A4B1ED0380D@oracle.com>
References: <20240917224837.478684-1-yifei.l.liu@oracle.com>
 <6cdd7cc3-e5ca-48b0-bd49-d33bbf908cda@linuxfoundation.org>
 <504209C8-0565-413D-BE89-A0ADE4E153AF@oracle.com>
 <9c1e9b57-649f-4f96-ab5d-ea512e05c1b9@linuxfoundation.org>
In-Reply-To: <9c1e9b57-649f-4f96-ab5d-ea512e05c1b9@linuxfoundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR10MB7634:EE_|SJ0PR10MB5693:EE_
x-ms-office365-filtering-correlation-id: a53a6a3b-86d6-4eca-1dab-08dcd99cfa14
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?THcxK0pRUHc5QXFVRE1sYU9OQzJva0xId2tsTms0QVE3R1g1RG91S3lVOTF4?=
 =?utf-8?B?dk5qN3NZUUpGTm0yczFKYUV4OVFtWnBBM3c4VVFPU3pUQlVxZjdlNTNtOXd4?=
 =?utf-8?B?WTBjVm1iRjRBSVQ5QTRSL2lWZVR4V3hUZi8ybHlXTWMwVGcvb1lnT1Yrekk5?=
 =?utf-8?B?WDlUQnM3dkdlYys0YmtiZGtHZUZhOWV2VGFQNXVzNVdJL2hhams1ODNNOUFk?=
 =?utf-8?B?K01LVVZxcFR2SjR1SW5PYkpvYmZ0bGZId1dzMHRvSjFKTER1bXhydVl6amNB?=
 =?utf-8?B?VjM0UDg4Tm5xNjUvQklSMUJYai84SnRaamJ1S3IwK0NEd1R6eFRvNTF4TFNH?=
 =?utf-8?B?anFvc1ppekdGMGRXcTBLMFVOditTZTZ3MUZ4SDllU0EvbzhlblU0TGpvcGx2?=
 =?utf-8?B?ZHVmNUorSzVGY0ZWLzhzbnArTGcxL2FtbGQvMUVsOFhrR1ZpbTFJTkNDVGlX?=
 =?utf-8?B?Tk1GS2c4aWdqUWRWMGl1ODNzTWxOdHNPemN3SUVKRFdlQVpvaGlVWElGUEdu?=
 =?utf-8?B?TnRUMWloZW1jMEhDQ3JPVlBlN1NWcXpzemVQdXZjcWpidXFuWWxKbCtDMkVs?=
 =?utf-8?B?UEJPdGFpckdaMlVKNUxUU0xOdFhFZVB2Y3V1TnpJNnVOT0xERXdwSXE4V2x1?=
 =?utf-8?B?YkhlYTVYM3lJL3Z6RXl1bXFJN3BNVWJ3NGsrbFBXQnlqRHBCVncvSGZIbXA4?=
 =?utf-8?B?aHJGa1U2K0VVZ3lzQmIwYjZNMVpoM2YzcFNZYzhaOVNuWUpDa2NuK2dDcFpx?=
 =?utf-8?B?RFhKN1ZVaG5EQmpyTEMwUHcxdFdVMjNnQm0wYzVEU2hFK0FEMlhiR3VCRG4r?=
 =?utf-8?B?MUJ6RXdUQUJWQXBXcktNQ3BlNUpsbDN2c3Y2QkpVY09YQkJFZXNrVys2anI1?=
 =?utf-8?B?eDIwR2RFNTMyVG1HanRzLzZxZ0VLL1o4a0JkbnpIVXllbk9tZG9ZejJLYlox?=
 =?utf-8?B?L1VTU0drNXpLcHpQZHVHQklENHp2RjA3L01YN1o1MHBucWhkMmk1WW1sTHJC?=
 =?utf-8?B?bjZCS2hyWXZlTHB6WmVzeVBDdkxBdE9YdnlRdEthUFdpVE9VaVZhdGQ3RlE2?=
 =?utf-8?B?bGJWamdhZWloNytZcEZJdHFKUGJ1V3FINVFHOTVaVUtSdzVsbXIrK1F3aUlI?=
 =?utf-8?B?amxZblFaRWZpU2cvcTB0M1BmRDRnNmkrNHR6Q0hadlhKNXE1UE9SVEpDOHd2?=
 =?utf-8?B?ajdielpvMjBFcUt3NmVaMHZnVGdDd1JtampUbnBFS3JnRlVYK0FpNXMzTmRI?=
 =?utf-8?B?ZHVGN3haKzZUSWJhaDA5NGNQNUEycnI0dHRReVBnOXIwZGQwY0U0Y3BYSmVU?=
 =?utf-8?B?TGs0QlFHN2p3T2wraTBqRVNZZlFYTU9zcjNPWW9iV2Z5c0ZPZXg0NzF3VHM1?=
 =?utf-8?B?VG1ZTVBWZkRPQUxuWStOYmhSMUxBeGg5YmEwL2NLVWdNaXZFRmY0YjhKa1dZ?=
 =?utf-8?B?ajVyUFA5aVZUeWFSYzJ5ekxyblFHNTZrS0tlVkpaQVo4VTJGTXlSR1RpaWcx?=
 =?utf-8?B?V3dQMzdoeGE1TWc1bDYrMmEzOXhkcE9qZTJGY092bHEybHlUcVcyMjBkYlNN?=
 =?utf-8?B?bXdBQUdxT0ZYaU1LaSswZDh3MzJCYVJkZkg5YVlPeEZlbHpXV3dNYVJXWkxp?=
 =?utf-8?B?cVRqT0VVT1VJRDRydnlqR3N4TURRWVJyeGtzbk5RTkd0ZGcxdmYzL0JrVWxN?=
 =?utf-8?B?WndtZnQ0alJpRFM0OVQ0Wmd4bm5kbXhjOEF5eWNOODM1dnM4S0NNeVpxaUoy?=
 =?utf-8?B?S3RuMEN6Z25QeXM4aWsrdkhpdzhSMTc5QXM5QlliTVNQcStJcUIvQW0zaCt6?=
 =?utf-8?B?SGY3NmxmOVJVTkgya1paczYxaVFLOFNpZU1waUo5UFR5Ry9xVmtVWnA2YlI4?=
 =?utf-8?B?ZmZEM0Y1QmdVQzFLNC9DSjB1cXJBMForM0YwUkd6K0p0L0E9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR10MB7634.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aTlJWTJwS2dvUm5MeDBlNGhvQTdCa0M2QUVGZ293eHJkNXdrcjNsQ1N6Z2h1?=
 =?utf-8?B?Y0VlUlcwMHVWWmMvN2d5dU9DT0l2em1MNjZBUyt0YmlsTkRPRVRCaWtUOHNG?=
 =?utf-8?B?RlplVkFMSnNzN3BBSldkMkJ6cGhRZ0F0TE1ReDd2UnhvQnZENzJNSkgvZUda?=
 =?utf-8?B?bXlXdENaZHVJeU5PenZpYStDbE55azRTK3daZ1J2cUhwWDZsU1YrSkpneTAv?=
 =?utf-8?B?UExGRU9xeEIvRHFOS0FIK3poZ0FWb0djQkpVcC9LOGcwaTBXWUNzcldPREFX?=
 =?utf-8?B?d0FkT1NsT2tZcGxzYTBHdGtzV2xmcUFNZHhEMzZQd0Zjd1dKWVlOOW1DVHBR?=
 =?utf-8?B?emFOWnVFU0VQcHRLYldSR2R2N2hWTHdNSlZjcjZibjhZOEpreTFiOW5va3Vy?=
 =?utf-8?B?TjJoZmt2WllmVDFSOEorcUcwZHgzNkxTRnlMekI1ZjlBZytabXdBa0VRRHIz?=
 =?utf-8?B?NmFWOTNSaThqdy96MEhQb1FTcWkxSk55bW9qOXFncUxQQ0prbkY4bXFyamor?=
 =?utf-8?B?ckdEeDJmeUlNU1p2R3Z4WlArQkkvTjFQOWk3Q0pNem9CQ2luYi9YVDZhZVhC?=
 =?utf-8?B?b2U0OGdjNmoybEZQeGttTlNMYWV6MkVYTFZQTmZWQVQzaW1pdXpoRTV4dTM2?=
 =?utf-8?B?UUtxd0kxdjBwN3FGd2hPQS8xb0lFT05ZNXF3OVlFVHdYUUQxKzFtaXVFVzIw?=
 =?utf-8?B?SXdOc0x4aWJnOU5TRkJQWmNIUDlmVjVkdW1Zd1JXOEZiaWtLQkJ5NUxkS2Vo?=
 =?utf-8?B?c283QTVLaFZaTEdsSXppRnIwNlZ5bkhKYnpZeHBVV3VLcy9pNkRUMG9IZVNX?=
 =?utf-8?B?ZnRxaVpzcE1ZMFZWRE5iMmxKaUtMWU9IN25MSnFPbjZ3OGNPbGlMcmtqTHhT?=
 =?utf-8?B?WDc2MUFaVUlsRkRsN3RMTHlmUnZzYzVkTUVVTWFsNm5SK1pQOVBqQmwwNlA5?=
 =?utf-8?B?NjVjb1REeG5WR0tKV2drQWtPYlg5MjlQdkR4TmUrdDZHdjV0SkJUL1E3MDND?=
 =?utf-8?B?SlVvNkRqWVBCZnRJN1I3TUlKN2xTbFFwRkcxWGhMSEdHWkxadWU1eGZDOVNW?=
 =?utf-8?B?OEZNUHcxdG55NGlEYloyZU9zdUwyMndORTJROVBVMGlFNGp2WVZ3OVlNMElp?=
 =?utf-8?B?b0NsZ1BFM2xWditBQXdxd2JxcVUrSzJ5MjJGQXNsRmpyck9DUjE0QjFWbWRU?=
 =?utf-8?B?K3dQa3U5b25nRWpqdFliQ1ExOG9UbHpDLzRseGdsTkxIQ3VLYUVnZEo1Q0dO?=
 =?utf-8?B?REhQYWdKUTVXakxjd1NtcHd0czdqSWtDZ1poL3I0VG9lZE4ramFYU2dtQ0Rp?=
 =?utf-8?B?VVBPUHpxL0ZNQVRnNFk0dklueW0zR2grM1Q0bE1XNTFVeUM2MzVQR2RoYlNq?=
 =?utf-8?B?N0kxYTZ5N1krdEc1a3loWW5tUTNMTmk0elc5dENqS3lzVUV0QitBWThiWkxI?=
 =?utf-8?B?MVNnUGNmbG9wUDJmMjZVK1p6b3c5YkZRWEVYL3dhNTFzRnVhanc4Z1VaSm1w?=
 =?utf-8?B?VVEwMTF3M2ZnenowdkpNSVA0ZThQQ2dqMHZtTTNaZXlqVTYySlRDV2hnc0xU?=
 =?utf-8?B?dmJpa2NpNnFYTDhpVTRCaWg0QXJ3REtrZzlNUHY5bThhOFQ5MUJheFp1UCsy?=
 =?utf-8?B?R2xHY1lSQTQ3b1dHWjJvVk9TQ2dmZHNOM2IxSWwvUW11L0tEcjk5Q1RsdjVl?=
 =?utf-8?B?M3lLcjZIb1RXOUM0QW8wRnVueVpRNXU4YXpacTJjOVJHVk5FNi9YbzBZVnd1?=
 =?utf-8?B?aHlWQkE2MGpRWGN6QU9sZHdBRERFa2h3Z2h4enlBU1pIdmpnNktPUlA1ajg0?=
 =?utf-8?B?QTI4Qllwb2JQdGlOaC9SMndLS3dlbElHNFZrcjh1RTBlanlRYURHcjB2U3pz?=
 =?utf-8?B?dU5sV1Z3Q0Q2Njd0UVpzLzY5Vi92L0huQjViaGFhMFJlNlhRZEtvL2x5K0F4?=
 =?utf-8?B?VEQzNGZueW5WTlZqeW1xOStnSnNxVlU0U1lFN1liSUxQbWZGZTJGZFRGdlBz?=
 =?utf-8?B?dGxUbFVHdUlqNTdYUHBDZ1c3dUh1ajBHZlR1R3BqQVdmMXQyZDFTMG84MUp3?=
 =?utf-8?B?Q0ROblgveFpIOUJ1WGIvWURwR0V6V3FjR0VHVW1GMmVoZGxZZXNkTEloVFJ0?=
 =?utf-8?B?aURZTlZwcVZjYm8xVlV5eUI4eXpJRUdBbEs4RldQdjkrNTgvNFNBNU5XNWIy?=
 =?utf-8?Q?Zxja9DxQeHMr+lIXIUkoXkY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D70BE219E030A7489261DCB6656FCF38@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	j0ZezDtuElzMgMK0ubpDQBjwH6oqo0Tpdpktth/rElmDxXg6Iv2Qb85PWBVvldIeBTmTheFAT+CEbWYKjPkhVhx3vnSF2FYvhZaskyDqjxogFV5AFzucEC1lV1Jz6j6vnhtbRpMZgINeXRKTLk9O+recpYPEW+vj4WeXcSfDewdAQkeBKax4KYXgykMjWZcgK4pAbR64bA2G9meTpEDSho0+UyzO3/quE+krr/lf5L4/dCpsak8tQkNPCFh5pJ36CNXilwaqZ2B+S7ZoRJPewMQY2xRIsn+q4pUOvg1b6GJLJ1k2/iDGMBAtT+id0JMIsej1V+dJ8wNgbawAAkMKt62YuyzCmeJJSltEdZZ7LT4hPogDq4clRIWXrJ7JEC7rujiH+qYp0vU3f/O6GG2b1QM3bpiCPPCzaV7j/oEAQeZEoHJ4dLaG0tW7pvotToLUPFTPEV6pwpVPmwjgDfticxoA2IGZPsExp1fTGVXDSASZUk4HklRo8fLpXC3ujpYKwve7T84rbesICvBC8eGut9Wpf+BXYFt+B9ZETbFeph/MfDKeyQqbTJGynGXP6y3zCC+n7NjBDEHLWGpaex2N1XW1sV8Ssg01F+4Tr5j+mkQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB7634.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a53a6a3b-86d6-4eca-1dab-08dcd99cfa14
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2024 17:52:21.3109
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5jGLyXf55JgE+MS0r8kSpDHnFxao5DwfEMcPMvj9klf0elsmW1G4mWkqAdN278xeoM+UsCh9QVhD6tV1NvsDYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5693
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-20_08,2024-09-19_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 malwarescore=0 suspectscore=0 mlxscore=0 phishscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409200130
X-Proofpoint-GUID: nwmhmSutFumeQBI8otbNLZvYVMoZewYR
X-Proofpoint-ORIG-GUID: nwmhmSutFumeQBI8otbNLZvYVMoZewYR

SGkgU2h1YWgsDQoNCj4gT24gU2VwIDIwLCAyMDI0LCBhdCA4OjA34oCvQU0sIFNodWFoIEtoYW4g
PHNraGFuQGxpbnV4Zm91bmRhdGlvbi5vcmc+IHdyb3RlOg0KPiANCj4gT24gOS8xOS8yNCAxNzow
OSwgWWlmZWkgTGl1IHdyb3RlOg0KPj4gSGkgU2h1YWgsDQo+Pj4gT24gU2VwIDE5LCAyMDI0LCBh
dCAxMTozNuKAr0FNLCBTaHVhaCBLaGFuIDxza2hhbkBsaW51eGZvdW5kYXRpb24ub3JnPiB3cm90
ZToNCj4+PiANCj4+PiBPbiA5LzE3LzI0IDE2OjQ4LCBZaWZlaSBMaXUgd3JvdGU6DQo+Pj4+IFdl
IHJlY2VudGx5IG5vdGljZSB0aGF0IHRoZSBzdGVwX2FmdGVyX3N1c3BlbmRfdGVzdCB3b3VsZA0K
Pj4+PiBmYWlsIG9uIG91ciBwbGVudHkgZGV2aWNlcy4gIFRoZSB0ZXN0IGJlbGlldmVzaXQgZmFp
bGVkIHRvDQo+Pj4gDQo+Pj4gV2hhdCBhcmUgInBsZW50eSBkZXZpY2VzIg0KPj4+IHJlY2VudGx5
IG5vdGljZWQ/DQo+PiBXZSBoYXZlIHNlZW4gdGhpcyBpc3N1ZSBvbiBtb3JlIHRoYW4gb25lIHBs
YXRmb3JtcywgaW5jbHVkaW5nIGJhcmUgbWV0YWwgZGV2aWNlIGFuZCB2aXJ0dWFsIG1hY2hpbmUu
DQo+Pj4gVHlwbyAtIGJlbGlldmVzaXQ/DQo+PiBZZXMsIG1pc3NpbmcgYSBzcGFjZSBoZXJlLiBJ
dCBzaG91bGQgYmUNCj4+IFRoZSB0ZXN0IGJlbGlldmVzIGl0c2VsZiBmZmFpbGVkIHRvIGVudGVy
IHN1c3BlbmQgc3RhdGUuDQo+PiBUaGFuayB5b3UgZm9yIHBvaW50aW5nIG91dC4NCj4+PiANCj4+
Pj4gZW50ZXIgc3VzcGVuZCBzdGF0ZSB3aXRoDQo+Pj4+ICQgc3VkbyAuL3N0ZXBfYWZ0ZXJfc3Vz
cGVuZF90ZXN0DQo+Pj4+IFRBUCB2ZXJzaW9uIDEzDQo+Pj4+IEJhaWwgb3V0ISBGYWlsZWQgdG8g
ZW50ZXIgU3VzcGVuZCBzdGF0ZQ0KPj4+PiBIb3dldmVyLCBpbiB0aGUga2VybmVsIG1lc3NhZ2Us
IEkgaW5kZWVkIHNlZSB0aGUgc3lzdGVtIGdldA0KPj4+PiBzdXNwZW5kZWQgYW5kIHRoZW4gd2Fr
ZSB1cCBsYXRlci4NCj4+Pj4gWzYxMTE3Mi4wMzMxMDhdIFBNOiBzdXNwZW5kIGVudHJ5IChzMmlk
bGUpDQo+Pj4+IFs2MTExNzIuMDQ0OTQwXSBGaWxlc3lzdGVtcyBzeW5jOiAwLjAwNiBzZWNvbmRz
DQo+Pj4+IFs2MTExNzIuMDUyMjU0XSBGcmVlemluZyB1c2VyIHNwYWNlIHByb2Nlc3Nlcw0KPj4+
PiBbNjExMTcyLjA1OTMxOV0gRnJlZXppbmcgdXNlciBzcGFjZSBwcm9jZXNzZXMgY29tcGxldGVk
IChlbGFwc2VkIDAuMDAxIHNlY29uZHMpDQo+Pj4+IFs2MTExNzIuMDY3OTIwXSBPT00ga2lsbGVy
IGRpc2FibGVkLg0KPj4+PiBbNjExMTcyLjA3MjQ2NV0gRnJlZXppbmcgcmVtYWluaW5nIGZyZWV6
YWJsZSB0YXNrcw0KPj4+PiBbNjExMTcyLjA4MDMzMl0gRnJlZXppbmcgcmVtYWluaW5nIGZyZWV6
YWJsZSB0YXNrcyBjb21wbGV0ZWQgKGVsYXBzZWQgMC4wMDEgc2Vjb25kcykNCj4+Pj4gWzYxMTE3
Mi4wODk3MjRdIHByaW50azogU3VzcGVuZGluZyBjb25zb2xlKHMpICh1c2Ugbm9fY29uc29sZV9z
dXNwZW5kIHRvIGRlYnVnKQ0KPj4+PiBbNjExMTcyLjExNzEyNl0gc2VyaWFsIDAwOjAzOiBkaXNh
YmxlZA0KPj4+PiAtLS0gc29tZSBvdGhlciBoYXJkd2FyZSBnZXQgcmVjb25uZWN0ZWQgLS0tDQo+
Pj4+IFs2MTEyMDMuMTM2Mjc3XSBPT00ga2lsbGVyIGVuYWJsZWQuDQo+Pj4+IFs2MTEyMDMuMTQw
NjM3XSBSZXN0YXJ0aW5nIHRhc2tzIC4uLg0KPj4+PiBbNjExMjAzLjE0MTEzNV0gdXNiIDEtOC4x
OiBVU0IgZGlzY29ubmVjdCwgZGV2aWNlIG51bWJlciA3DQo+Pj4+IFs2MTEyMDMuMTQxNzU1XSBk
b25lLg0KPj4+PiBbNjExMjAzLjE1NTI2OF0gcmFuZG9tOiBjcm5nIHJlc2VlZGVkIG9uIHN5c3Rl
bSByZXN1bXB0aW9uDQo+Pj4+IFs2MTEyMDMuMTYyMDU5XSBQTTogc3VzcGVuZCBleGl0DQo+Pj4+
IEFmdGVyIGludmVzdGlnYXRpb24sIEkgbm90aWNlIHRoYXQgZm9yIHRoZSBjb2RlIGJsb2NrDQo+
Pj4+IGlmICh3cml0ZShwb3dlcl9zdGF0ZV9mZCwgIm1lbSIsIHN0cmxlbigibWVtIikpICE9IHN0
cmxlbigibWVtIikpDQo+Pj4+IGtzZnRfZXhpdF9mYWlsX21zZygiRmFpbGVkIHRvIGVudGVyIFN1
c3BlbmQgc3RhdGVcbiIpOw0KPj4+PiBUaGUgd3JpdGUgd2lsbCByZXR1cm4gLTEgYW5kIGVycm5v
IGlzIHNldCB0byAxNiAoZGV2aWNlIGJ1c3kpLg0KPj4+PiBJdCBzaG91bGQgYmUgY2F1c2VkIGJ5
IHRoZSB3cml0ZSBmdW5jdGlvbiBpcyBub3Qgc3VjY2Vzc2Z1bGx5IHJldHVybmVkDQo+Pj4+IGJl
Zm9yZSB0aGUgc3lzdGVtIHN1c3BlbmQgYW5kIHRoZSByZXR1cm4gdmFsdWUgZ2V0IG1lc3NlZCB3
aGVuIHdha2luZyB1cC4NCj4+Pj4gQXMgYSByZXN1bHQsIEl0IG1heSBiZSBiZXR0ZXIgdG8gY2hl
Y2sgdGhlIHRpbWUgcGFzc2VkIG9mIHRob3NlIGZldyBpbnN0cnVjdGlvbnMNCj4+Pj4gdG8gZGV0
ZXJtaW5lIHdoZXRoZXIgdGhlIHN1c3BlbmQgaXMgZXhlY3V0ZWQgY29ycmVjdGx5IGZvciBpdCBp
cyBwcmV0dHkgaGFyZCB0bw0KPj4+PiBleGVjdXRlIHRob3NlIGZldyBsaW5lcyBmb3IgNCBzZWNv
bmRzLCBvciBldmVuIG1vcmUgaWYgaXQgaXMgbm90IGxvbmcgZW5vdWdoLg0KPj4+IA0KPj4+IEkg
ZG9uJ3QgdGhpbmsgdGhpcyBpcyB0aGUgcmlnaHQgZml4LiBDYW4geW91IGNoYW5nZSB0aGlzIHRv
IGRvIGVjaG8gaW5zdGVhZC4NCj4+PiBJdCBkb2VzIHRoZSBzYW1lIHRoaW5nLCBidXQgaXQgZ29l
cyB0aHJvdWdoIHN5c2ZzIGludGVyZmFjZSBpbnN0ZWFkIG9mIGRpcmVjdA0KPj4+IHdyaXRlOg0K
Pj4+IA0KPj4+IHJldCA9IHN5c3RlbSgiZWNobyBtZW0gPiAvc3lzL3Bvd2VyL3N0YXRl4oCdKTsN
Cj4+IFN1cmUsIEkgY2FuIGRvIHRoYXQuDQo+Pj4gDQo+Pj4+IEZpeGVzOiBiZmQwOTJiOGMyNzI4
ICgic2VsZnRlc3RzOiBicmVha3BvaW50OiBhZGQgc3RlcF9hZnRlcl9zdXNwZW5kX3Rlc3QiKQ0K
Pj4+PiBSZXBvcnRlZC1ieTogU2luYWRpbiBTaGFuIDxzaW5hZGluLnNoYW5Ab3JhY2xlLmNvbT4N
Cj4+Pj4gU2lnbmVkLW9mZi1ieTogWWlmZWkgTGl1IDx5aWZlaS5sLmxpdUBvcmFjbGUuY29tPg0K
Pj4+PiAtLS0NCj4+Pj4gIC4uLi9zZWxmdGVzdHMvYnJlYWtwb2ludHMvc3RlcF9hZnRlcl9zdXNw
ZW5kX3Rlc3QuYyAgICAgIHwgOSArKysrKysrLS0NCj4+Pj4gIDEgZmlsZSBjaGFuZ2VkLCA3IGlu
c2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+Pj4+IGRpZmYgLS1naXQgYS90b29scy90ZXN0
aW5nL3NlbGZ0ZXN0cy9icmVha3BvaW50cy9zdGVwX2FmdGVyX3N1c3BlbmRfdGVzdC5jIGIvdG9v
bHMvdGVzdGluZy9zZWxmdGVzdHMvYnJlYWtwb2ludHMvc3RlcF9hZnRlcl9zdXNwZW5kX3Rlc3Qu
Yw0KPj4+PiBpbmRleCBkZmVjMzFmYjliMzBkLi5kNjE1ZjA5MWU1YmFlIDEwMDY0NA0KPj4+PiAt
LS0gYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icmVha3BvaW50cy9zdGVwX2FmdGVyX3N1c3Bl
bmRfdGVzdC5jDQo+Pj4+ICsrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2JyZWFrcG9pbnRz
L3N0ZXBfYWZ0ZXJfc3VzcGVuZF90ZXN0LmMNCj4+Pj4gQEAgLTE4LDYgKzE4LDcgQEANCj4+Pj4g
ICNpbmNsdWRlIDxzeXMvdGltZXJmZC5oPg0KPj4+PiAgI2luY2x1ZGUgPHN5cy90eXBlcy5oPg0K
Pj4+PiAgI2luY2x1ZGUgPHN5cy93YWl0Lmg+DQo+Pj4+ICsjaW5jbHVkZSA8dGltZS5oPg0KPj4+
PiAgICAjaW5jbHVkZSAiLi4va3NlbGZ0ZXN0LmgiDQo+Pj4+ICBAQCAtMTMzLDYgKzEzNCw3IEBA
IHZvaWQgc3VzcGVuZCh2b2lkKQ0KPj4+PiAgIGludCB0aW1lcmZkOw0KPj4+PiAgIGludCBlcnI7
DQo+Pj4+ICAgc3RydWN0IGl0aW1lcnNwZWMgc3BlYyA9IHt9Ow0KPj4+PiArIGNsb2NrX3QgdDsN
Cj4+Pj4gICAgIGlmIChnZXR1aWQoKSAhPSAwKQ0KPj4+PiAgIGtzZnRfZXhpdF9za2lwKCJQbGVh
c2UgcnVuIHRoZSB0ZXN0IGFzIHJvb3QgLSBFeGl0aW5nLlxuIik7DQo+Pj4+IEBAIC0xNTIsOCAr
MTU0LDExIEBAIHZvaWQgc3VzcGVuZCh2b2lkKQ0KPj4+PiAgIGlmIChlcnIgPCAwKQ0KPj4+PiAg
IGtzZnRfZXhpdF9mYWlsX21zZygidGltZXJmZF9zZXR0aW1lKCkgZmFpbGVkXG4iKTsNCj4+PiAN
Cj4+PiBJIGRvbid0IHRoaW5rIHlvdSB3aWxsIG5lZWQgdG8gYWRkIGNsb2NrKCkgY29kZS4gdGlt
ZXJmZF9zZXR0aW1lKCkNCj4+PiBzZXRzIHRoZSB0aW1lIGZvciA1IHNlY29uZHMgYW5kIHlvdSBj
YW4gc2ltcGx5IGV4dGVuZCB0aGUgYWxhcm0NCj4+PiB0aW1lLg0KPj4+IA0KPj4+IFRoZXJlIG5l
ZWRzIHRvIGJlIHNvbWUgbG9naWMgdG8gY2hlY2sgdGltZXIgZWxhcHNlIGFuZCBwb2xsIHRoZQ0K
Pj4+IHRpbWVyX2ZkDQo+PiBZZXMsIGl0IGlzIGFsc28gYSBjaG9pY2UgdG8gY2hlY2sgdGhlIHJl
bWFpbmluZyB0aW1lIG9mIHRoZSB0aW1lci4gV2UgY291bGQgdXNlIHRpbWVyZmRfZ2V0dGltZSgp
IHRvIGdldCB0aGUgcmVtYWluaW5nIHRpbWUuIFRoZSB0aW1lciB3b3VsZCBub3QgcmVhcm0gYmVj
YXVzZSB0aGUgaXRfaW50ZXJ2YWwgdmFsdWUgaXMgbm90IHNldCAoc2V0IHRvIDApLiBUaGVuIGlm
IHRoZSByZW1haW5pbmcgdGltZSBoYXMgYm90aCAwIG9yIHNlY29uZHMgYW5kIG5hbm8tc2Vjb25k
cyAodHZfc2VjIGFuZCB0dl9uc2VjKSwgaXQgc2hvdWxkIHBvaW50IG91dCB0aGUgdGltZSBnb2Vz
IGZvciBhdCBsZWFzdCA1IHNlY29uZHMuIElmIHRoZSBzeXN0ZW0gZmFpbHMgdG8gZW50ZXIgc3Vz
cGVuZCBzdGF0ZSBhbmQgd2FrZWQgdXAgYnkgdGhlIHRpbWVyLCBpdCBzaG91bGQgbm90IHRha2Ug
NSB3aG9sZSBzZWNvbmRzIG9yIG1vcmUgdG8gZ2V0IHRvIHRoZSBjaGVjayBsaW5lLg0KPiANCj4g
UmlnaHQsIFlvdSB3aWxsIGhhdmUgdG8gY2hlY2sgdGhlIHJlbWFpbmluZyB0aW1lLiBUaGVyZSBp
cyBhbiBleGFtcGxlIGluDQo+IHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3RpbWVycy9hbGFybXRp
bWVyLXN1c3BlbmQuYyB5b3UgY2FuIHJlZmVyIHRvLg0KSSBjaGVja2VkIHRoZSByZW1haW5pbmcg
dmFsdWUsIGlmIHRoZSBzdXNwZW5kIHN1Y2NlZWQsIGl0IHdvdWxkIGJlIGFsbCAwICgwcyBhbmQg
MCBucykuIElmIGl0IGZhaWxlZCB0byBlbnRlciBzdXNwZW5kIGJ5IGFueSBjaGFuY2UsIGl0IHdv
dWxkIGJlIGEgbm9uLXplcm8gdmFsdWUuIA0KPiANCj4+IFdvdWxkIHlvdSBwcmVmZXIgdGhpcyBt
ZXRob2RzPw0KPiANCj4gSSBhbSBjdXJpb3VzIHdoYXQgaGFwcGVucyB3aXRoIHN0YXJ0aW5nIHN1
c3BlbmQgd2l0aCBzeXNmcyBmaXJzdCBhbmQgdGhlbg0KPiBleHBsb3JlIGNoZWNraW5nIGVsYXBz
ZWQgdGltZXIuDQo+IA0KPiBzeXN0ZW0oImVjaG8gbWVtID4gL3N5cy9wb3dlci9zdGF0ZeKAnSk7
DQpJIGNoZWNrZWQgdGhpcywgYW5kIGZpbmQgdGhhdCBpdCB3aWxsIGdpdmUgYSBzaW1pbGFyIGZh
aWx1cmUuIA0KDQpzaDogbGluZSAxOiBlY2hvOiB3cml0ZSBlcnJvcjogRGV2aWNlIG9yIHJlc291
cmNlIGJ1c3kNCg0KVGhlIGNvbnNvbGUgY29tbWFuZCB3aWxsIGdldCBpdHMgcmV0dXJuIHJlc3Vs
dCBhZnRlciB0aGUgc3VzcGVuZCBhbmQgd2FrZSB1cC4gTWF5YmUgd2UgY291bGQgZG8gDQoNCnN5
c3RlbSgiZWNobyBtZW0gPiAvc3lzL3Bvd2VyL3N0YXRlID4vZGV2L251bOKAnSk7DQoNClRvIGF2
b2lkIGFuIGVycm9yIG1lc3NhZ2UgaW4gdGhlIGNvbnNvbGUuIEFuZCB3ZSBhcmUgY2hlY2tpbmcg
dGhlIHN1Y2Nlc3Mgb2Ygc3VzcGVuZCBieSB0aGUgdGltZSwgc28gaXQgd291bGQgbm90IGJlIG5l
Y2Vzc2FyeSBmb3IgdXMgdG8gc2VlIHRoZSBvdXRwdXQgb2YgdGhpcyBjb25zb2xlIGNvbW1hbmQu
IA0KDQoNCj4gDQo+IHRoYW5rcywNCj4gLS0gU2h1YWgNCg0KWWlmZWkNCg0KDQo=

