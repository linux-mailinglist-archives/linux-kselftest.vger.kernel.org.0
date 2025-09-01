Return-Path: <linux-kselftest+bounces-40458-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A97B3E96F
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Sep 2025 17:19:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2193D482BC4
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Sep 2025 15:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A68BB352FF1;
	Mon,  1 Sep 2025 15:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b="pHS5KJW5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fra-out-004.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-004.esa.eu-central-1.outbound.mail-perimeter.amazon.com [3.74.81.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218C0352FEF;
	Mon,  1 Sep 2025 15:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=3.74.81.189
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756739303; cv=fail; b=Lh7YBDnu3to8lHWQjQ8H7k9Meofc1xhpVc5ho1ueiE4kjAqbGd/4cURCFVnaxBekOCQ4WULNE5/9rLLqMguFSQXbNDdbR99QiKlWQmCXpeoSr+C/eaRrQkpFicravBQWjFUAbxxfX8t4bCvC+J6MdKu0g3DiKHxOhSVauDzePrA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756739303; c=relaxed/simple;
	bh=JFDJAgFUSF+NfZEEINB5U1c3w6tdqgtpw/CNnwASuSI=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dRmFOU8ysprCQzJEtNHE484CHYzpIjcXtCrF54oDNPJjU77gkPGzXHuqJWk9ibDeBjx/WvvVhuM/EgU2bS/S8VrF6N1/u6MKisx1gW9RSI8UqPBRp1axegLbA1ahW7iSNrcfThQ/PrP0bGQ5LKznqEKA7tKkGeFx9T11fiP9NoQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b=pHS5KJW5; arc=fail smtp.client-ip=3.74.81.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.uk; i=@amazon.co.uk; q=dns/txt;
  s=amazoncorp2; t=1756739301; x=1788275301;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version:subject;
  bh=JFDJAgFUSF+NfZEEINB5U1c3w6tdqgtpw/CNnwASuSI=;
  b=pHS5KJW53MIIWtqsyJ+BADXGS6QrDo2Y31m/qCWy5kDAtxp/0A032fhL
   BopoP/4WQRZlfsqKv7p3YeXCpGobv+iAZ5KDSny7SPKfyuHy5wTYzBmAg
   eNxkVRNiwVSj3ONd2N0YWZ+QFi2GdwYaHg+ExLAqApAYyRP5sqy1y7f+h
   etx45yCXjUwajSFnRrPv7tujxNYGgq1wnwKOVR3asWsb+3vF+VvEY9Zde
   rM76W860KLxZRQJRKtfNHbshnBk+wCh1Rkp+FePj/+2rZWBKVqi31Um95
   cPFWSs6kz3yOLPleFQBisrIeWLaIcX+k/1wNgOP59iVk3VzGCD+KEYW+F
   A==;
X-CSE-ConnectionGUID: POj0Wj87SV+83By8pHCzuQ==
X-CSE-MsgGUID: 5vBjUxu3Sd+K4hOJpuWTLw==
X-IronPort-AV: E=Sophos;i="6.18,214,1751241600"; 
   d="scan'208";a="1471179"
Subject: Re: [PATCH 2/9] KVM: selftests: Add __packed attribute fallback
Thread-Topic: [PATCH 2/9] KVM: selftests: Add __packed attribute fallback
Received: from ip-10-6-6-97.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.6.97])
  by internal-fra-out-004.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2025 15:08:11 +0000
Received: from EX19MTAEUA001.ant.amazon.com [54.240.197.233:26620]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.18.194:2525] with esmtp (Farcaster)
 id c390483c-7533-40f5-aac1-381ac1964b99; Mon, 1 Sep 2025 15:08:11 +0000 (UTC)
X-Farcaster-Flow-ID: c390483c-7533-40f5-aac1-381ac1964b99
Received: from EX19EXOEUA002.ant.amazon.com (10.252.50.139) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.192) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.17;
 Mon, 1 Sep 2025 15:08:10 +0000
Received: from CWXP265CU009.outbound.protection.outlook.com (10.252.50.44) by
 EX19EXOEUA002.ant.amazon.com (10.252.50.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.17
 via Frontend Transport; Mon, 1 Sep 2025 15:08:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pz3PRIhkGKK8DDFhwy8CnEZ9mn8f4v5WLHxcpSdxKK4+5UJcc2Ehbycq2OZh0vU1oRReFwvV4wPn6TfQGz1Thcpq13FAe4vBYCwDKqLxMnvY6A1sn44CpevMhIjiHj5Ekm6RA8XzfxedSJcFf0rBxv/7lVgd4rJmmtagUSqy8JD4FmSbh25x9cTfGY92bnvfn66iHuDTc6OUElr6FZ35J0ccibv0naWlASVvatUgCmK8xru+llvBLWPqPOWHcHKXxb2h+FH9Mgd5I9H5rpwzfZHQ387t9RRsxMfHgtQSsOri/S9R/YCTYvGa91VO+iB6WeYurKS2XTROtUeF0Rsx3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JFDJAgFUSF+NfZEEINB5U1c3w6tdqgtpw/CNnwASuSI=;
 b=G/dVpfr4ZPdIx8Bpp2WL7qFJXFU9b2VvbGbuCor0N37IOCMufIE+nN+fgPh5AZyMnl35S/PVvfUu2dcCO7WmgmYvYR4dzjzlXhAoc9OjwR2dFg0TXapIzgMUI7Z88icjXvWwHd7sSJzgpjASJmWfcV96rirufp3IodxHTJJBlse7BoL0CUo2LCUxJ4uBZn4Je+mpOlEgDiztOikBBHFiPhf+juWTMVjfJBBwjuOBrqn0rRtaxmqHkBND1JIU7rDKc/38KauUXe18Okqi784vOxkzKRrNQ0KlsvP/h7Y47ZLLA4sV57/R6c9UtXG+GbBs0rhleshwQx8eOZgdrmCsHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amazon.co.uk; dmarc=pass action=none header.from=amazon.co.uk;
 dkim=pass header.d=amazon.co.uk; arc=none
Received: from CWLP123MB5987.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:1c3::10)
 by LO2P123MB7195.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:328::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Mon, 1 Sep
 2025 15:08:09 +0000
Received: from CWLP123MB5987.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de60:77f:f7f2:4422]) by CWLP123MB5987.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de60:77f:f7f2:4422%6]) with mapi id 15.20.9073.026; Mon, 1 Sep 2025
 15:08:09 +0000
From: "Faruqui, Aqib" <aqibaf@amazon.co.uk>
To: Sean Christopherson <seanjc@google.com>
CC: Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"nh-open-source@amazon.com" <nh-open-source@amazon.com>
Thread-Index: AQHcGPEEmEBHoVan1E2j+VVEVYG6QbR6O76AgARHlgA=
Date: Mon, 1 Sep 2025 15:08:09 +0000
Message-ID: <ACE55B66-3A0B-4990-B51D-57711E5E4E5F@amazon.com>
References: <20250829142556.72577-1-aqibaf@amazon.com>
 <20250829142556.72577-3-aqibaf@amazon.com> <aLIt3bm0uxSh8I1j@google.com>
In-Reply-To: <aLIt3bm0uxSh8I1j@google.com>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels: MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_Enabled=true;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_SetDate=2025-09-01T14:57:57Z;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_ContentBits=0;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_Enabled=true;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_Tag=50,
 3, 0,
 1;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_Name=Confidential;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_ActionId=8f575c75-435a-4b27-83bb-f55907751e2f;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_SiteId=5280104a-472d-4538-9ccf-1e1d0efe8b1b;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amazon.co.uk;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CWLP123MB5987:EE_|LO2P123MB7195:EE_
x-ms-office365-filtering-correlation-id: f69d16df-d8ec-4a6c-afb3-08dde9695cac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?RTBCSnhnc2tyQmNsZ0ZoaHFBSmRDd2Y0WkUzZnRiV3ZqcjNyYytWTU9BRnQv?=
 =?utf-8?B?ZVBFbHVHRHNZM01udWVsemdxZ1krSlBEK1FuYThrQTZlcDFQbUFvdS9VclIw?=
 =?utf-8?B?Ympqdk91S3NuRE51eElsbHl1b1JKbTk1ek42S2dNOCtoY3F4eFpkeit0OS91?=
 =?utf-8?B?TEwycXN5aWxpcGI3K0IxWnBSL2QzbEcvQUlIQ21xUlgxcSt1LysxNGcyYlJI?=
 =?utf-8?B?ZEJpdXBwMkttWGZTeXFhU1A4WEVmMkJYdlNqVmg0VW9wTlV2ZVFRMUFocmlE?=
 =?utf-8?B?b1ZlUW1QMFRvSWJrcW5OUy9ldWRlRkRNYnFlNThwSWlPT1JSMjZvSWR4azNB?=
 =?utf-8?B?Z29DSFFiWDgvTEZPL0VXN1hJRTY1ZGJIYXBycHByMzY4TmIvUkswcUt1REFJ?=
 =?utf-8?B?U2loYk5SbnEwZ2YwK25PdU9sc1RKeEkrRm9lQTE3amhKdGtNb1UwOXI4TmJi?=
 =?utf-8?B?Nkc3MDFsU3dQbUNKQXd2b1hCU094Zk9ZWjg4MHFINUdMZW9PWmorNTRDTFJh?=
 =?utf-8?B?VmR5LzVmSkFSSUhrKzF3cCtIWDN4QTZCcGtlK3IyMDlWZy9hTm5tVmZLMmNO?=
 =?utf-8?B?ZlJqY1JwTVhITFh3OExIMG5kOTA1dFNTVUdqWlFuVjdGMmIyYUV4YkJHMEJZ?=
 =?utf-8?B?dnlRb2g3aHVGb2p0bTFMaXJRRFFTWGZJRmp2VU1obzNUR0JIazdUeER6WWY2?=
 =?utf-8?B?TVM0bGF3SGZrR2NQM2NGS1hBKzFQc2kveVBQOGUvaC8xS0NSWTQ3Z3BoLzVB?=
 =?utf-8?B?K1kyMlVEZ2l5Wmx6eHVOSXZmZXVZV01MQnZYQ2xsc2ZGdE9DWGNSUGlhaGhq?=
 =?utf-8?B?U2czS21kWEY3QmpLREJ2Ujl6OHNGckZlRkluNnkxU1NGL1BnSDJobkh5MEx2?=
 =?utf-8?B?SVo0SFFhRjE4RWR3ZWdmNXdSK3BRekFSclVVeTVyN3lRTTNGVzZIRU91ZzVS?=
 =?utf-8?B?Q1U3bnM3MXJVODVnQXBJek5ucC9sYkd5NDQ0YzBKckE4QUkwOUtGK0FadWVs?=
 =?utf-8?B?cUhZYUtnUmdLdXl5dmYydUNMb3luN3RYN2xwQSs0QkpqK04wcSs5ODA3SWE4?=
 =?utf-8?B?T2JJUS9YOE9GVktwT0Y3Qm5TRDZLMFRqU1M3cjR5TGIwcTRtcFhFV2I3M0VL?=
 =?utf-8?B?SFluOFovSThycXd4ZFlYUkYxemw1YWZVVFdQUUwyREJ0RjM4YTFLS3J3Q2Jj?=
 =?utf-8?B?U0txNzNITHB6OFlJbXJDMmVNenpsditsRGhvTVI1UmZjNjV2WjRjaUV4VWFI?=
 =?utf-8?B?SkZOT3ljaEhTMG5MZHM4T25sZ3JZOTZUQkQ4eHd5UE5zelNwb2VlRE1VMjEr?=
 =?utf-8?B?WGh6SXZGOSs0a0hhSk9HN0llM0hOWEEvM0FRZzQzSTlkVWhCR0JwcGduOTdJ?=
 =?utf-8?B?NWRDYnY0RE4wMldDZjFNaitNSkZoTEVYTEE0amNoZERDaUlIMU5PWnkzQ3ho?=
 =?utf-8?B?SWZmTVJEeWF1MERuY1ZSSU92a2JBeTNLRld2d3BNM1FXbDgrOFp1dzM2eVBF?=
 =?utf-8?B?V1R0eTdVUzhLcTc0cUZXNGtQQTNmRkVFZU9BTWNqV2xTb0NVQk5PaFVwNDNF?=
 =?utf-8?B?RGN3Tk5oTitvNXNhMVBBTXBLQVlSWWRleWtVQk9JMWR3V1JiUi9VaGt6Z0FS?=
 =?utf-8?B?cVoyVG1DbnJFNU5GZlN0R0pVN2x2dm5uNGJHNGtRWFlzZVhabjd1US9CcWJz?=
 =?utf-8?B?VTE2MzZIQUxGTU53eGc1cFlWRlZhKzJtZmVVcmVqUEFVbHZOT1JIcmZwbmJC?=
 =?utf-8?B?ajVuRGlsRGZIWDRxK3k2eXdMMXRVeitIY0xZOXRaYUlCeFFYU3FpZmp5THJm?=
 =?utf-8?B?K0tWSmszajgxdG5hQUVKa3E1RE9TNHhXSHdnbzBoSlNtSmhIaUZMZERmL21k?=
 =?utf-8?B?L0o4NzEzNXpWbWoxcDVjdE1ySjQyRmovL1JnMkFjM1czV3BaUVdSWTMvdFRH?=
 =?utf-8?B?TlIvNUdsY2syQm5qNHlvRXdSeHRYK2hxc00wNVdways1SXpZS3JJZ2gxVHZP?=
 =?utf-8?B?elVlYTVML0ZnPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB5987.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dkQzQ3EyamJDaFlsYUJERWlaSGYrd3M4dnExdmtwM0h6V2oySGFlTk1nMk1C?=
 =?utf-8?B?Y0RyaWsxSDg2R0krTjBqYjVaRlgyR0R0STVFb3JOUGp0TmJPRnpWN1lGcjdU?=
 =?utf-8?B?djJ6L3ZteUxpbUdWcEFuVE1iZml1U3Z4WnRrclRKZy8zOFNRK1FaSC9GS1R2?=
 =?utf-8?B?YXQzeHkyUzRXdlkvaG1yUWtLRksyTnVEV3cvL29laWF3NlBDYWxHLzMwMHlj?=
 =?utf-8?B?T1ZndExaTWo1WHNVNk5PQTF0bEJ5Q0U5T0NlTkNQczduQi9nbldhQS9KVTg4?=
 =?utf-8?B?anBOKzQxUkNwRkJZL01Gc1IvWHhJbnoybmlhTmJTeHVmR09kcE1KS1k5ckhQ?=
 =?utf-8?B?Vm1YMTNpYUdzWXQyWENXeDNrUTVKM1I0TnlLT1dMMDhscWNZektWZkhHcUR4?=
 =?utf-8?B?WktwajFaWVQxeWFsTWYzeXNwL3RBaEFWWjFwNnQ5NThpOVlUNFZaUWRQbDdC?=
 =?utf-8?B?TEl3OVI0NnNURi9wcytiaEJXbUhDS1hkQklZckxOWUZLU0ljOFBjWFl2anh0?=
 =?utf-8?B?ZHRNdFNOZHBabE1YU2dqbTlyRWxRaEhTeGRBakEycUJQMURRejM0akkrTDZ0?=
 =?utf-8?B?T29BTVVjN09IVEhBZUdnc2pXQ2ZWQ1Y0ZWJMbkFRSnpWL0E0TzR6U2l6b0NR?=
 =?utf-8?B?ZUtUd3J6M0FDMXYxTDVHZktjR1ZhamhTYjg3Yk5KWkNtSGVlNXJnd0VvTVhJ?=
 =?utf-8?B?czNXbHRQVmU5UWdQN3RlTW5icGU2d1F1d3Z0R002ZzhnME1EUUFPeExveUVJ?=
 =?utf-8?B?K0IyOFROZzJ0WjI3dXZnckt3dVQ3c2JlcGp5USt1NVZ0b3oxc2RkTVM0ZTM5?=
 =?utf-8?B?dDN4eVgwRllRbU9FMi9OdXVnMzB0WUtqYjN3cjlDNUY3T2NHaWVmNlFpaDRl?=
 =?utf-8?B?M2ZOajRULzZURzFnNk5OWWFzYW1NbU9EZ2JIZjdjV0NkVi9rY1gwVEdsZzhY?=
 =?utf-8?B?VFlsODdzVGJNbFNZK0JQZzNzaGVGb0dacld1eGF5NXRzVVNNRDRRbVJhNDRz?=
 =?utf-8?B?R2pzWU5HYitETE1MMHVkUDhNb2hxV1RoSUs2VE5ZcnB3ZlQ3N3hsd3l1ZUk4?=
 =?utf-8?B?cWZkMUF5K05TMVUxYmVYK2dEWWVDTFlKaXk4Wm8zdHBqL2QrRmRRZEpQMmFD?=
 =?utf-8?B?Qk9GT25SQVNtdVdvem1oeElHMzF4T0JoSHErMlo4S3VUTkJmQVlwZmNVWjFl?=
 =?utf-8?B?M252Nmo4SkFPUHZmaWFKaTdVcWFhQzgxTHp0encrMktKWVZWeGJOWmlrcXZ2?=
 =?utf-8?B?Uk96d09ybHZqLy9zSmxtODNPMmRuSmVDTW0zYnR3MVN6KzNPN3dGOFlPdjZP?=
 =?utf-8?B?ZjhFUFNtajNmR29IWWpURFQ3dkIwQUl6NUxwZmF3RXJkeXF2S1lRckRhclF0?=
 =?utf-8?B?UGl1alYzZ0N2OWI4TmYzcjlDcHZnUHhPaEtwTk1KNzJwU3k2cENEK1VxaHZL?=
 =?utf-8?B?RXhWUVRkS0Q4TnQ0YzkxSlZFUCtLVW1MMnpDYXpXaHlQS3dXVm1SeTYrM1Jp?=
 =?utf-8?B?MVJMcGZDYVlkMk1VdzJWU0ROWG5haTBSZ1BGRk1URVNKRENjQzB5SlVpQnIr?=
 =?utf-8?B?TVY5d1AwMnQ1N1RWZzhFZHRVNVRHeDFndXFpUmZxL2NJTDZxWmxlZnB6enFk?=
 =?utf-8?B?OVJFSnkzTElEZzVoM1U5d25iOS9QTnpJbnRsRnBvSk45bk1jRTdwamQ1UTkz?=
 =?utf-8?B?bjZkckxVcExaV1Yvc1R2M0ZuZEh1dG5vM0ZYc0NheVV1b0JsNGNWQXB2di9n?=
 =?utf-8?B?NUIwbDZNb3RucWsrUFRYckllZlFhV25GTkVNUTBVa2U3NGhPZFNOWDRTUnhw?=
 =?utf-8?B?cWRYUVhaZUZoZDJSWXgzQ2tBSm5uZXkxajMweDNVdDczeDU2aUJlWFJMaC9r?=
 =?utf-8?B?SDh0LzVNWE5uMFUrejNMT1gyQ3ZGQ1NpQ3ZramJKSzlpNU54Q1I3dm9Ba3Bl?=
 =?utf-8?B?VzNmYStQVVlxc1gzQUdzaE92SlNVQWxjbW9mbzZ0K2o3d1NRaHV6eFZEMzJ0?=
 =?utf-8?B?WGhzVlJKUzRYRzFIbHlJOFR6OVJwR3VOSndUcktiRzZFa3ljVk5GSGtROXhk?=
 =?utf-8?B?QkJ3RXUxQXR4R3JieUhlblFidVdyN2hrZTAwc081TXhLWStmdDFaVktmWXh5?=
 =?utf-8?Q?E7/31MiGif/aLp36h+vlwT2RG?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C16383062FDA5845BDE8415F0B61FEF2@GBRP123.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB5987.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f69d16df-d8ec-4a6c-afb3-08dde9695cac
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2025 15:08:09.2001
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5280104a-472d-4538-9ccf-1e1d0efe8b1b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a8ltoCc3F9Fpxe6npQa5uML2vnU+jDt/n5+OVcbSnTt3xsZdnsIiLHcnZjM5hUgoEmHsKKqQVw+yl5m4/9PJ8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P123MB7195
X-OriginatorOrg: amazon.co.uk

QWZ0ZXIgaW52ZXN0aWdhdGluZyBhIGxpdHRsZSwgbG9va3MgbGlrZSB0b29scy9pbmNsdWRlL2xp
bnV4L2NvbXBpbGVyLmggYWxyZWFkeSBkZWZpbmVzIF9fcGFja2VkIGNvcnJlY3RseS4gV2hpbGUg
VUFQSSBoZWFkZXJzIChlLmcuIGxpbnV4L2t2bS5oKSB1c2UgX19wYWNrZWQgYnV0IGRvbid0IGlu
Y2x1ZGUgaXQgdGhlbXNlbHZlcywgdGhlIGluY2x1ZGUgb3JkZXJpbmcgbG9va3MgZmluZSBmb3Ig
dGhpcyB0byBiZSBoYW5kbGVkIGJ5IHRoZSBidWlsZCBzeXN0ZW0uDQoNCkknbGwgZHJvcCB0aGlz
IHBhdGNoIGFuZCBpbnZlc3RpZ2F0ZSBmdXJ0aGVyIHdoeSB0aGUgdG9vbHMgaW5mcmFzdHJ1Y3R1
cmUgaXNuJ3Qgd29ya2luZyBjb3JyZWN0bHkgaW4gbXkgc2V0dXAuDQoNClRoYW5rcyBmb3IgdGhl
IGZlZWRiYWNrIQ0KDQotLSANCkFxaWIgRmFydXF1aSANClNvZnR3YXJlIERldiBJbnRlcm4gKEVt
YmVkZGVkKSB8IEVDMiBBY2NlbGVyYXRlZCBOaXRybyB8IEFXUyANCis0NCA3NzYzMTA0NDEzIA0K
DQoNCg0KDQrvu79PbiAyOS8wOC8yMDI1LCAyMzo0OCwgIlNlYW4gQ2hyaXN0b3BoZXJzb24iIDxz
ZWFuamNAZ29vZ2xlLmNvbSA8bWFpbHRvOnNlYW5qY0Bnb29nbGUuY29tPj4gd3JvdGU6DQoNCg0K
Q0FVVElPTjogVGhpcyBlbWFpbCBvcmlnaW5hdGVkIGZyb20gb3V0c2lkZSBvZiB0aGUgb3JnYW5p
emF0aW9uLiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91
IGNhbiBjb25maXJtIHRoZSBzZW5kZXIgYW5kIGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZS4NCg0K
DQoNCg0KDQoNCk9uIEZyaSwgQXVnIDI5LCAyMDI1LCBBcWliIEZhcnVxdWkgd3JvdGU6DQo+IEtl
cm5lbCBVQVBJIGhlYWRlcnMgdXNlIF9fcGFja2VkIGJ1dCBkb24ndCBwcm92aWRlIHRoZSBkZWZp
bml0aW9uIGluDQo+IHVzZXJzcGFjZSBidWlsZHMuDQo+DQo+IEFkZCBhIGZhbGxiYWNrIGRlZmlu
aXRpb24gbWF0Y2hpbmcgdGhlIGtlcm5lbCdzIGltcGxlbWVudGF0aW9uLiBUaGlzDQo+IGZvbGxv
d3MgdGhlIHNhbWUgcGF0dGVybiB1c2VkIGJ5IEJQRiBhbmQgU0dYIHNlbGZ0ZXN0cy4NCg0KDQpV
Z2guIE5vLCB0aGlzIG5lZWRzIHRvIGJlIGZpeGVkIGluIGEgY2VudHJhbCBsb2NhdGlvbiwgbm90
IHNwbGF0dGVyZWQgYWxsIG92ZXINCnJhbmRvbSBzdWJzeXN0ZW0gc2VsZnRlc3RzLiBNeSBmaXJz
dCBjaG9pY2Ugd291bGQgYmUgdG8gY29weSAoYW5kIGtlZXAgc3luY2hyb25pemUpDQphbGwgb2Yg
dGhlIGluY2x1ZGUvbGludXgvY29tcGlsZXIqLmggaGVhZGVycyB0byB0b29scy9pbmNsdWRlL2xp
bnV4Ly4NCg0KDQpJZiBmb3Igc29tZSByZWFzb24gdGhhdCdzIG5vdCBhIHZpYWJsZSBvcHRpb24s
IHdlIHNob3VsZCB5YW5rIHRoZSBfX3BhY2tlZCBhbmQNCnNpbWlsYXIgI2RlZmluZXMgb3V0IG9m
IHRvb2xzL2luY2x1ZGUvbGludXgvY29tcGlsZXItZ2NjLmggYW5kIHBsYWNlIHRoZW0gaW4NCnRv
b2xzL2luY2x1ZGUvbGludXgvY29tcGlsZXIuaC4gQUZBSUNULCBub25lIG9mIHRoZW0gYXJlIGFj
dHVhbGx5IEdDQy1vbmx5Lg0KDQoNCj4gU2lnbmVkLW9mZi1ieTogQXFpYiBGYXJ1cXVpIDxhcWli
YWZAYW1hem9uLmNvbSA8bWFpbHRvOmFxaWJhZkBhbWF6b24uY29tPj4NCj4gLS0tDQo+IHRvb2xz
L3Rlc3Rpbmcvc2VsZnRlc3RzL2t2bS9pbmNsdWRlL2t2bV91dGlsLmggfCA0ICsrKysNCj4gMSBm
aWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvdG9vbHMvdGVz
dGluZy9zZWxmdGVzdHMva3ZtL2luY2x1ZGUva3ZtX3V0aWwuaCBiL3Rvb2xzL3Rlc3Rpbmcvc2Vs
ZnRlc3RzL2t2bS9pbmNsdWRlL2t2bV91dGlsLmgNCj4gaW5kZXggMjNhNTA2ZDdlLi43ZmFlN2Y1
ZTcgMTAwNjQ0DQo+IC0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2t2bS9pbmNsdWRlL2t2
bV91dGlsLmgNCj4gKysrIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMva3ZtL2luY2x1ZGUva3Zt
X3V0aWwuaA0KPiBAQCAtNSw2ICs1LDEwIEBADQo+ICNpZm5kZWYgU0VMRlRFU1RfS1ZNX1VUSUxf
SA0KPiAjZGVmaW5lIFNFTEZURVNUX0tWTV9VVElMX0gNCj4NCj4gKyNpZm5kZWYgX19wYWNrZWQN
Cj4gKyNkZWZpbmUgX19wYWNrZWQgX19hdHRyaWJ1dGVfXygoX19wYWNrZWRfXykpDQo+ICsjZW5k
aWYNCj4gKw0KPiAjaW5jbHVkZSAidGVzdF91dGlsLmgiDQo+DQo+ICNpbmNsdWRlIDxsaW51eC9j
b21waWxlci5oPg0KPiAtLQ0KPiAyLjQ3LjMNCj4NCg0KDQoNCg==

