Return-Path: <linux-kselftest+bounces-32888-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65335AB48A4
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 May 2025 03:09:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 856F0166208
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 May 2025 01:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA58514D43D;
	Tue, 13 May 2025 01:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cfNGO7cy";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="McbISAjx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB6317578;
	Tue, 13 May 2025 01:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747098538; cv=fail; b=fVpHsViTVWoZU7fCNKPClcD90DEKl1UN0iej/5J3plOV+UpZT6igwwmPIHjBvw2Qnr+ysaFQIfH+rq/jw3GgSVsPUvHy9G8vkXKlCvouUaslPulo2L9OURpn6Z4Z9HmJKX5gPPw2QxZGGz6+lpgIYyia5VT2LnPFO/svQE+Bw4w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747098538; c=relaxed/simple;
	bh=Mzp2GRv1csQyoNm7YbVGjjHDGFdbJo+dn4VRSeIE0Bg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ArPzIlzQ/ktWV6VK1/CTD91/4lLAnf5DxQLLmGzDYxaH4IoFyK56aDO9Z6HGX2gVjBKM0nNIR22MdaaJa02Vh3jOtcSrEMj0Jafa5pHrcFihSAtMyLyLHXuYtvUOkR/dNvFU8TXgOm3FTa2clahXaqgO3RqdSPKkSd9UeaudD34=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cfNGO7cy; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=McbISAjx; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54CK6rGN021097;
	Tue, 13 May 2025 01:08:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=ABteegjHsbOCc9CARAo1bBB6KhHah7pmpFz+jybBO3U=; b=
	cfNGO7cyvaBuKbmnKZH7KwjpyPauCIg+z3OWpPNespMwVhWSVZDEiwpCNnwMnTr8
	eD7iK++8CWgWE/8g+7kGw/ZfjYgUoO8mmpU4gRrVS9h9EpKpLQw5Jpjm/MFPzH9T
	23jrxmGko0+1gaqqE7nJEny4LFiQJswAlRSr6cn0ewpRbv4fndRIRjeELgAtBWfU
	mXOSZKtO3xmqS9eruETHy91qMJrJqtSS5a+3w6L9R0YZuiaeM96ZmqGZfSIVFlHP
	eloZu1A0md+LJspDfZ81JOCWuJvGstjr2HsGH5+4v8AHdzMW7NtwVf7BNbrGgVYB
	qZAIx+Kgrqa6+gsSv5x5rQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46j11c3n98-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 May 2025 01:08:27 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54D03LmY002520;
	Tue, 13 May 2025 01:08:26 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazlp17012015.outbound.protection.outlook.com [40.93.14.15])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46jwx3qcc4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 May 2025 01:08:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oH2niASvpuhw8ZYOnAuvKMQFGwULKIeEEvyAp8B8zyMU4rqR9NkKHdwFhFqRdgIxAwGzKvesxwv0HFcWbDvrhNmwaeYigOgGNze9n6Gdu13irGTYhGQygIle5UqVX7guoQtRPaOcPM44DyxNklvWKkJ740O6ckk1cxzQvpr/+ao88K8EqYcSEv3EzZdkukelrYK6b8WypKoVgh7RDzuPwM07SzP3gw8UQ5gPXyN5NXRXaNT0aDH8v3jY6iWTy/GJ0nVRUvAf6W7Z6ivuz8dyYhdoAXpeE4n2eBjepO/bzIZMPZqGvdQu8C8vc9pm7tPVOw8I+rOA68G+Gv/rzqNRmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ABteegjHsbOCc9CARAo1bBB6KhHah7pmpFz+jybBO3U=;
 b=Pe1+/RJzzEddizXeOmInN+0XbA2NIkWPRA5wNagskHCrMdfZ1B0WbNZ29PwRtWFs5MXCBG2XfGKkDMdyU2+FdoM+kW+37XEgdR+CpIptRb455hYHVBuGK1L5ggXa7GgVARoF0a4wFYarFRtQeFBS80oZ9EoVvrZjqaj1SlgUkf45YBrejClSX1Wotu2oWaRG4Vg2tK4og2R65w2CZY9j7H663zuTSC90+xjivrJzqowT9YKFU2cc1VbIKe7k2YXHmxl0Ue0BQodr6kh/ODYF7HHG/eJpsxkgXPFVex9ZocnXTBHvUZq2KK83oVMq/iJvXDi7RJ57SSL514oINgK2SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ABteegjHsbOCc9CARAo1bBB6KhHah7pmpFz+jybBO3U=;
 b=McbISAjxOkWJ6Se/jsH4LckvLOAIgYrropQQWA6PVR3tDBFd4xLxPUYq8WLnmgvm5w2+Dg+673bWTUJaLtIXCRIRq+xnY7GQYCYkeitVc5o3Uc5jYBrlzj+ZZTmb38hboFdO3tgv5J5UL7JC3dQSewj5wpzZandKOxmtKfXa0nw=
Received: from DS7PR10MB5280.namprd10.prod.outlook.com (2603:10b6:5:3a7::5) by
 PH3PPF0A8D5CDB5.namprd10.prod.outlook.com (2603:10b6:518:1::788) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.25; Tue, 13 May
 2025 01:08:08 +0000
Received: from DS7PR10MB5280.namprd10.prod.outlook.com
 ([fe80::da22:796e:d798:14da]) by DS7PR10MB5280.namprd10.prod.outlook.com
 ([fe80::da22:796e:d798:14da%3]) with mapi id 15.20.8699.022; Tue, 13 May 2025
 01:08:08 +0000
Message-ID: <9a9ed15f-eb0e-45ce-8c21-ef74539aa9c2@oracle.com>
Date: Mon, 12 May 2025 21:08:05 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/15] Consolidate iommu page table implementations
 (AMD)
To: Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
        iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
        Justin Stitt <justinstitt@google.com>,
        Kevin Tian <kevin.tian@intel.com>, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, llvm@lists.linux.dev,
        Bill Wendling <morbo@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Will Deacon <will@kernel.org>
Cc: Alexey Kardashevskiy <aik@amd.com>, James Gowans <jgowans@amazon.com>,
        Michael Roth <michael.roth@amd.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>, patches@lists.linux.dev
References: <0-v2-5c26bde5c22d+58b-iommu_pt_jgg@nvidia.com>
Content-Language: en-US
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
In-Reply-To: <0-v2-5c26bde5c22d+58b-iommu_pt_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1P223CA0009.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::14) To DS7PR10MB5280.namprd10.prod.outlook.com
 (2603:10b6:5:3a7::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5280:EE_|PH3PPF0A8D5CDB5:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e62b8cc-0a95-4e9f-8539-08dd91ba9f8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cUFITmFkUytCVnZtSnpZbUEzdkRGT0NqNmlqUURmQlB2S0x1a3FrSWs3cHl5?=
 =?utf-8?B?UUZhUHZlM2o4K2FRdUFtc2tNN1Vpa09RSHVNbjAxNWI5N1ZWdU9NbnB6L0hZ?=
 =?utf-8?B?NkJTMGhZQ24yUmZJL3NYSTJ4WDRrTE9VeVNJUVFld1VzbExxd0VhSHAxTDdL?=
 =?utf-8?B?WFdHYk9FTTUraU9Sa1I4dWFxakJhR2FIRWw3Z29NSW1TeHpvWkVTY3M4NStI?=
 =?utf-8?B?KzBUaWJ3dHNOeXVGYmJzenNNdkR0Qk83Q2krQ3hrY28wNEw2emQxVzBtazho?=
 =?utf-8?B?bmV0WURROW5ZbjdocjkxUjBub3VYRmJIMlJ4T05kNE5PYzZwcjNvOS80WjF5?=
 =?utf-8?B?ZUJWcXZXcTMvSjBoYncrcVVBTi9BRldiQVFXYU9UY3RJOHJoVng5TE9EVVd2?=
 =?utf-8?B?SEk0Sm9ZSVYzV3JuYnZ2aU5PakxYTWdKWVJERUJPeGtaWGRTaHUxbmowQnhO?=
 =?utf-8?B?UlV2bzMyUUpKNVdKbVZrdVpmcWJNN1lUN3JZOFNMNVo4ckpSbVlRVlZiUzN4?=
 =?utf-8?B?NEhROUxVcHVyZmFWTmJML05zVVprd294Z2R2eDVuTEdBVjRkVTlaeUdycUxn?=
 =?utf-8?B?dEFqNDAzeWpkNWRySE1qc2NTT0toM2pXSUJIWXRPSmRKMUdtUy9rTHhNSExt?=
 =?utf-8?B?dGRXUmN2Y1dLeEdXY2lLbmF2WTNzL0xOVkVlZWNWandKekljSGk4dFZ3WmU3?=
 =?utf-8?B?L2Q0SGgvREJYWktlTVgzbk02b3kveE96U2JvL2NPWnRjazlSa3pjWURyN3N4?=
 =?utf-8?B?RmJ0d2pwSmI0Ykhscmp2Zjd1MGJkbHB6VG4rbW9sM1REVUh5NitONHo1Mmdm?=
 =?utf-8?B?L29HbEZQS1IrN1dPNURBZjFISi9UekZYSm1jTVU3NE1zS1kwbGVUZWU5ZjdP?=
 =?utf-8?B?Qk0rdlNTb1diaDA2MjlEdUxVSDRUaWtvVDVRelFLRkY2NnVFR0lSK29SMmxx?=
 =?utf-8?B?OEplSTlLb1NZMTJDL0ZWOGU3K2VKOWhsdVVpeU5jeG8rUWQ4WjJ3UUxVNkJk?=
 =?utf-8?B?d0xXU0xIYmZUc09mSEtUR0F2MU5MVWVMSzFVcm9oSEUxRkdNeGZSOWxQMUdl?=
 =?utf-8?B?VXVnMExrNXlyZVFDQ0FxcVFmdGZXYUFHeHpRVEc2cE1lMEtyNnJFRlV6Sldi?=
 =?utf-8?B?OXhzS1NlR0szZThHOEhGUDlaa1Y2SER0amlDc0ZieEpqRTRtbUVVNU11eEVm?=
 =?utf-8?B?QXpZeER6TFNwU29SSlorRUxXR3RHMnRtZlp5aE8weTVzWFZLT3N2MG8rdzlt?=
 =?utf-8?B?NTY0cFowZ09BSVFhNlQ5Z20rQXVuNmRrSk1GcHZyTXc0TnZXQmx2dzl1T3JE?=
 =?utf-8?B?UUM0eWJQOExBMlJTYzdnOUUrU1k1dit5SjNZQnBWQUtmQTFCcE44TWdaSGhR?=
 =?utf-8?B?RElYQnA3aWxUMnFzQm5LSW5iUXVOVG9WaTliZ0lndzdmYkZnNnRQNVlyOWdh?=
 =?utf-8?B?U1pjcGF1bmNVQWNScjJjR2N5d3ZSQ29uN3hwY2ZpbjJFT2Jmb2RmTkRMTCth?=
 =?utf-8?B?aUFWRjBNbkZPV3VFalVMZW45enRNelJ2dGtwQ1Z3a2lOeGlSR3FXT0NldWdY?=
 =?utf-8?B?ckR3VmdYNFZKeFN5OFdCQWFTYytjaStvTnlNQXY0UmRXSlVoeDNXRHZ5eDZL?=
 =?utf-8?B?WlNIMUMzaXhxbUQwK0tIaUp2QW9mN3dmVWlUdjgxcHE4NmhLelMzUlJZUU5l?=
 =?utf-8?B?b2owSmk3c1gwNEtocVJGcFV6VmVZYmZveHk4bUpkTUk4T2NqS3FlUTd0d2pT?=
 =?utf-8?B?QmxORjhOWUJvK1MwVllCYTFFUlZMTENSM3NPS2xaWXhhc2pYOUtoTXhQMmxr?=
 =?utf-8?B?SUZzckorYjZFVU42bzRORENER25uVks2THpLSmNZMUhtTDRxMDV3R09KWG5z?=
 =?utf-8?B?dzR6aTMxU1Y0Y1cyTWpnK1V1VzV5WWdkaTlYckRscWp5RUk0NFN4RFp6QURy?=
 =?utf-8?Q?TAnhtSPRZJw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5280.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TjQ0djRPcThIZGdPVjlJMVFiMEUrMzBGYlNITjVDczE5TWk1YndUSmlyZTBJ?=
 =?utf-8?B?amdoT2VEazdTcGhuOFgwUDNMVUd0ejF5Ymw1UGE5U25BT05UZXRhNjJ0TGR0?=
 =?utf-8?B?MWpjTHJSdWRkcGJDNW9wekc5NXdxYjY3OUQ4aTZhcTdrWURvRVdKbzJrT1Mw?=
 =?utf-8?B?SW5UZStUMjdaaldzYzQ4ak5nTWhiMWczM2lDRGxpSTBHaVIxbUVPaGNKLzZP?=
 =?utf-8?B?OEcrSWhCUTVzbDIvb0cyUkNwRXdmY1ROYjZSRUJRT2ZMdXorNUpocmt5aHAy?=
 =?utf-8?B?Z2Uzd0NDM05MTkNqdFFjaG50YXpIbGQ5bGg1KzZZZmEwQVY0QzZzY2xYNEty?=
 =?utf-8?B?dzg2Tk9oQWxXWmRnby8zVUxMZ0tncmVmZEcvZHZTdmx1b09QbXFqRVFGdHhY?=
 =?utf-8?B?cWFBd0RBQUJSVDQveURtVlBiNWtJWGVrSjUyNDlhVXd5RzBRVmNVNEFZVjdT?=
 =?utf-8?B?aS9rK2hhUEgxMWR6OXJ0M04yTkJhbHBCaDVEVTNCcURoQXZUQUM5NTdFR2Zy?=
 =?utf-8?B?cGlGYXJrTFJla05zTm5PWld3K2pCd3B6WVh6MU9nNkpMcGZaNDFnVUFISEVN?=
 =?utf-8?B?Ym04NmZySzR3K2NiNEUra1BoaEoxR0FlRnlJTXQzMkpBZkk0clQ5QnVlTUdp?=
 =?utf-8?B?YVh4WlFZMVhINDdhZmRyY1ZialRWL3BMNlFBanFEM3NkMzJDRjNWbnpKNVVw?=
 =?utf-8?B?U2ZuS25laGROOUJjY1FHaFczeTc5aktWQ0NTeGhEWFpnZVFHa1RFcHhOenNL?=
 =?utf-8?B?em5uSTFWWHJhZGx1UVhsRFRDdFdacFpUdGxuWkFTOGVUZlh5NU5SRUVvT3Z1?=
 =?utf-8?B?U2ptaksrWGRQZ1Z0Y1ZGQk1UM3JYWlJna2srSkhNYkVnQVBqR1JzVGtCeG9V?=
 =?utf-8?B?TUtZOHRSLzRacHlTWnJmMG82b0ZvK1AwZFlpZkZvZlBQVnBvUmdqTDJLUFJB?=
 =?utf-8?B?cUJvSHE2N2cwR1h4OFJzZWNMbDJEaUhSM0ZJN0Z4YlU1YTVYRUc3VGsvQ2hH?=
 =?utf-8?B?UW9INVZkWUtua0JsZDRIR1BMUkJ4bVNacjNMTWlPbFVXRnRway8xbHNkVGJY?=
 =?utf-8?B?QmprM2lHcDc0eDBIS0RRZDQ5TTd3RlZRSEJLaHFiNGlTbHV4QlpHc2lXREVE?=
 =?utf-8?B?OTNZanpzdHZ2VWJ5TEJDZjJwcFdWekswdnowakNvM0s3a2dpTENmd2k1UE5a?=
 =?utf-8?B?Ymo3ei9Dd2JhL1MvUkJTSFF6NUYzT240ajNHM1dSbVYxYUVCZjR6cnQvVDJH?=
 =?utf-8?B?T0tDSm14VlNWcWc4NW9xcmdqaFcwWlRhWkpyYjVYdTJSQ3ZqZUE5T3ZWdDV2?=
 =?utf-8?B?OVprVnBkNG9SY3d5TnpISFJEenVpTjk5ZXFtVXEyRlQ4VHd3cGxua2graTNV?=
 =?utf-8?B?SkNGTWE3bGZZN3FuY3ZsaXBFOWo3VlQ5ZS9yZVFGR2R4c2dZaU12WmhTQk9R?=
 =?utf-8?B?NmlaQ0YycW5RNGpTbi8xakdQa2g3SUtObkdEL0R6eHBybEVMbFZzMWJzVXU1?=
 =?utf-8?B?Nlo0alJpTXQxRTloZDJ4MFo0emZaTTY2U2xmUnlycUdHYmxHS1hJbzFzalk5?=
 =?utf-8?B?ZWpzTi9vaDhxVE53Ylg1UlZLTWZVR0FqQVR6ZlBqb3NqNDQ1eDBma2lxcU5q?=
 =?utf-8?B?V2dmbzRnK0NrSVdHSG84dlgvQ2dZbkl3Uk12MlNhRDJ2blFXQ25FOHA1bXlE?=
 =?utf-8?B?SkFGcFBHTmU1dXljZmY0SStmUVFaNGJ6OXpsMTRwakRleUhUa21zVXlKL202?=
 =?utf-8?B?elpTQTNodmthTGJPakdQNFhEbzZpcVhSb3ZiUitZSEltZE5UVjliUWF0UmY2?=
 =?utf-8?B?VkRxaXpmaWk0NXlOUS85N1NJbjJYb1k5WVZiQVZTU2pGUTJkaGNGdzl3cWhm?=
 =?utf-8?B?TE5uNEUwU0M3U3VPTDU5dUZhNUtTVG1SMGJiMzUyMVg0ZStSUmVPSFZzbkRh?=
 =?utf-8?B?bEdOR2ttK3UvMjZVMFVJYUNUQ3Z5blVpSGp1cDQ2T2dKb2R0QUlpSG9kWGh1?=
 =?utf-8?B?RlQxZ2gyeEtERjJKcXBodkl1UWhyWkxFd29xS3AvVzZYaUYxWDdoTnlFUDFm?=
 =?utf-8?B?a0ZscDVtanRkc1dxRTNZUUF1SDBuakdqVGRnRFlXKzk2aks4Z1VyYWZESWVz?=
 =?utf-8?B?VERGcndobUlNdjI0azJPeTFoeDNHa0NOYVhYNVdpYjB2VFNnZ3B5eG03L01K?=
 =?utf-8?B?TVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xnPdK3ZfBgorhJ7PP7morZ1yFcN5IRp0oB+fG8CXHbQsvffkKioq2XZPZy0EG2jhLUh5UKvAqQ7SILA6VfwKsu8LxIr+zOH6xX6dmbEjOeiXD+ap55sc00mVxrKjm5rsad2athACp7w8Z6OpxisirpaLl0Wyb3c6zqvlbptAAyqNYPb3d9pZkyW0q9hpFcwvMkgsys5aGCgReOTf97W8+07gBmNnwrHFqd1QbbdAXEO8QqIdGqUjUaHWcyRpN/g1FGG6Z4wqaS8BOUWkThnrr1Tirtt7r+AlC1HMCHWc2UVa57R80oVG1La7uJu814/TfucrXJBXNrdRwe/bjqe2df18iZStggl7rZWgl7/KzL+HBcXjN2EOi9HRvu9tpTq39g+tzjgtDzrv5Ygn4YYlD3I4jLAID7zjUi13APM+capAY9FSfSBtXng1Wlk9Hsi7mHUA1twQQx7c2qcJKurFmAkxh7gxKsW0JwDxnoT74b8OfstI/2fjRpZXdlEdIO4vwFZqTl329OMXK0bHDRqoPDqaaMkUId5qjt/OOMpIpWoobEAWscr8xqTd8MPxp8zpG+/d8hNA22lx9UrErEVYXKzbSVL7WziXLSS1oSuj368=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e62b8cc-0a95-4e9f-8539-08dd91ba9f8a
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5280.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 01:08:08.4585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tphSDft60EP5dl+C5X1C2wW3Uz7AL6WNrgEqy9SzcA0H/bVWPL2bof/fSSvchm0Z69K53biH3J0TnX3ZbfetKAeRjhOpJPuO0J1dhsiCnkk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF0A8D5CDB5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_07,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 spamscore=0
 bulkscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505130008
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEzMDAwOCBTYWx0ZWRfX7ZLhRXLQzNds /JeAmPifh9unqoMS+WY21Cr4ElmFDBDo6bZr5M05G8uHZbOXbl4pXyyGtAzRVtdyr6tNhr0pscF OVNhk3LvD+22UJZXK3vLm0R+HHeNl4SgWKRp8i7WP7DchzBGe/rtPHsuZo6ejvQJevDlwT3N4bv
 sRUHJZH39JLLjcSPuSjZ2cHB5X/SpWbzervhf97vRyD+yyx0AJLcpDDZtlxilRKKPiDGk6f0oAg xeDRYupHkbYESOtK1e7CkwA+C32z9luhb/3XDLc63cV4Hd0mJTJ8x8ViS7oW5X5G1eP5zgKGpLE V0MrbCmlExCkTELG0qeK6YFPiEdcldALE9gpbwv0+4ab+BwhkMKn7VkVR/8Gjt1cr0vAxcY9BIw
 l80y5yLW7XOak+x4KA9JYkbPGV5f+/wlN61Fh1m1UlzzmNlSqIt43hBYCouBzdsNruy26jVF
X-Authority-Analysis: v=2.4 cv=YJ2fyQGx c=1 sm=1 tr=0 ts=68229b8b b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=Ikd4Dj_1AAAA:8 a=yPCof4ZbAAAA:8 a=WKXPoHkJNs5XQI6iCNkA:9 a=bWvvlwC3WtSYmgSQ:21 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Ja0U6noqEQXLDpguhgyQuZvnZGHQIEg8
X-Proofpoint-ORIG-GUID: Ja0U6noqEQXLDpguhgyQuZvnZGHQIEg8



On 5/5/25 10:18 AM, Jason Gunthorpe wrote:
> Currently each of the iommu page table formats duplicates all of the logic
> to maintain the page table and perform map/unmap/etc operations. There are
> several different versions of the algorithms between all the different
> formats. The io-pgtable system provides an interface to help isolate the
> page table code from the iommu driver, but doesn't provide tools to
> implement the common algorithms.
> 
> This makes it very hard to improve the state of the pagetable code under
> the iommu domains as any proposed improvement needs to alter a large
> number of different driver code paths. Combined with a lack of software
> based testing this makes improvement in this area very hard.
> 
> iommufd wants several new page table operations:
>   - More efficient map/unmap operations, using iommufd's batching logic
>   - unmap that returns the physical addresses into a batch as it progresses
>   - cut that allows splitting areas so large pages can have holes
>     poked in them dynamically (ie guestmemfd hitless shared/private
>     transitions)
>   - More agressive freeing of table memory to avoid waste
>   - Fragmenting large pages so that dirty tracking can be more granular
>   - Reassembling large pages so that VMs can run at full IO performance
>     in migration/dirty tracking error flows
>   - KHO integration for kernel live upgrade
> 
> Together these are algorithmically complex enough to be a very significant
> task to go and implement in all the page table formats we support. Just
> the "server" focused drivers use almost all the formats (ARMv8 S1&S2 / x86
> PAE / AMDv1 / VT-D SS / RISCV)
> 
> Instead of doing the duplicated work, this series takes the first step to
> consolidate the algorithms into one places. In spirit it is similar to the
> work Christoph did a few years back to pull the redundant get_user_pages()
> implementations out of the arch code into core MM. This unlocked a great
> deal of improvement in that space in the following years. I would like to
> see the same benefit in iommu as well.
> 
> My first RFC showed a bigger picture with all most all formats and more
> algorithms. This series reorganizes that to be narrowly focused on just
> enough to convert the AMD driver to use the new mechanism.
> 
> kunit tests are provided that allow good testing of the algorithms and all
> formats on x86, nothing is arch specific.
> 
> AMD is one of the simpler options as the HW is quite uniform with few
> different options/bugs while still requiring the complicated contiguous
> pages support. The HW also has a very simple range based invalidation
> approach that is easy to implement.
> 
> The AMD v1 and AMD v2 page table formats are implemented bit for bit
> identical to the current code, tested using a compare kunit test that
> checks against the io-pgtable version (on github, see below).

I have tested the patchset on an AMD Zen 4 Bare Metal instance, booting 
in default passthrough and translated (i.e. iommu.passthrough=0) mode. 
Exercised both the default AMD v1 and AMD v2 (amd_iommu=pgtbl_v2) page 
table formats. Launched KVM guests with VFIO passthrough device. No 
issues found.

I also ran the x86_64 kunit test suite; all tests pass, except the 
(expected) skipped test_increase_level for the x86_64 format which does 
not have PT_FEAT_DYNAMIC_TOP.

Tested-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>

> 
> Updating the AMD driver to replace the io-pgtable layer with the new stuff
> is fairly straightforward now. The layering is fixed up in the new version
> so that all the invalidation goes through function pointers.
> 
> Several small fixing patches have come out of this as I've been fixing the
> problems that the test suite uncovers in the current code, and
> implementing the fixed version in iommupt.
> 
> On performance, there is a quite wide variety of implementation designs
> across all the drivers. Looking at some key performance across
> the main formats:
> 
> iommu_map():
>     pgsz  ,avg new,old ns, min new,old ns  , min % (+ve is better)
>       2^12,     53,66    ,      51,63      ,  19.19 (AMDV1)
>   256*2^12,    386,1909  ,     367,1795    ,  79.79
>   256*2^21,    362,1633  ,     355,1556    ,  77.77
> 
>       2^12,     56,62    ,      52,59      ,  11.11 (AMDv2)
>   256*2^12,    405,1355  ,     357,1292    ,  72.72
>   256*2^21,    393,1160  ,     358,1114    ,  67.67
> 
>       2^12,     55,65    ,      53,62      ,  14.14 (VTD second stage)
>   256*2^12,    391,518   ,     332,512     ,  35.35
>   256*2^21,    383,635   ,     336,624     ,  46.46
> 
>       2^12,     57,65    ,      55,63      ,  12.12 (ARM 64 bit)
>   256*2^12,    380,389   ,     361,369     ,   2.02
>   256*2^21,    358,419   ,     345,400     ,  13.13
> 
> iommu_unmap():
>     pgsz  ,avg new,old ns, min new,old ns  , min % (+ve is better)
>       2^12,     69,88    ,      65,85      ,  23.23 (AMDv1)
>   256*2^12,    353,6498  ,     331,6029    ,  94.94
>   256*2^21,    373,6014  ,     360,5706    ,  93.93
> 
>       2^12,     71,72    ,      66,69      ,   4.04 (AMDv2)
>   256*2^12,    228,891   ,     206,871     ,  76.76
>   256*2^21,    254,721   ,     245,711     ,  65.65
> 
>       2^12,     69,87    ,      65,82      ,  20.20 (VTD second stage)
>   256*2^12,    210,321   ,     200,315     ,  36.36
>   256*2^21,    255,349   ,     238,342     ,  30.30
> 
>       2^12,     72,77    ,      68,74      ,   8.08 (ARM 64 bit)
>   256*2^12,    521,357   ,     447,346     , -29.29
>   256*2^21,    489,358   ,     433,345     , -25.25
> 
>    * Above numbers include additional patches to remove the iommu_pgsize()
>      overheads. gcc 13.3.0, i7-12700
> 
> This version provides fairly consistent performance across formats. ARM
> unmap performance is quite different because this version supports
> contiguous pages and uses a very different algorithm for unmapping. Though
> why it is so worse compared to AMDv1 I haven't figured out yet.
> 
> The per-format commits include a more detailed chart.
> 
> There is a second branch:
>     https://github.com/jgunthorpe/linux/commits/iommu_pt_all
> Containing supporting work and future steps:
>   - ARM short descriptor (32 bit), ARM long descriptor (64 bit) formats
>   - VT-D second stage format
>   - DART v1 & v2 format
>   - Draft of a iommufd 'cut' operation to break down huge pages
>   - Draft of support for a DMA incoherent HW page table walker
>   - A compare test that checks the iommupt formats against the iopgtable
>     interface, including updating AMD to have a working iopgtable and patches
>     to make VT-D have an iopgtable for testing.
>   - A performance test to micro-benchmark map and unmap against iogptable
> 
> My strategy is to go one by one for the drivers:
>   - AMD driver conversion
>   - RISCV page table and driver
>   - Intel VT-D driver and VTDSS page table
>   - ARM SMMUv3
> 
> And concurrently work on the algorithm side:
>   - debugfs content dump, like VT-D has
>   - Cut support
>   - Increase/Decrease page size support
>   - map/unmap batching
>   - KHO
> 
> As we make more algorithm improvements the value to convert the drivers
> increases.
> 
> This is on github: https://github.com/jgunthorpe/linux/commits/iommu_pt
> 
> v1:
>   - AMD driver only, many code changes
> RFC: https://lore.kernel.org/all/0-v1-01fa10580981+1d-iommu_pt_jgg@nvidia.com/
> 
> Alejandro Jimenez (1):
>    iommu/amd: Use the generic iommu page table
> 
> Jason Gunthorpe (14):
>    genpt: Generic Page Table base API
>    genpt: Add Documentation/ files
>    iommupt: Add the basic structure of the iommu implementation
>    iommupt: Add the AMD IOMMU v1 page table format
>    iommupt: Add iova_to_phys op
>    iommupt: Add unmap_pages op
>    iommupt: Add map_pages op
>    iommupt: Add read_and_clear_dirty op
>    iommupt: Add a kunit test for Generic Page Table
>    iommupt: Add a mock pagetable format for iommufd selftest to use
>    iommufd: Change the selftest to use iommupt instead of xarray
>    iommupt: Add the x86 64 bit page table format
>    iommu/amd: Remove AMD io_pgtable support
>    iommupt: Add a kunit test for the IOMMU implementation
> 
>   .clang-format                                 |    1 +
>   Documentation/driver-api/generic_pt.rst       |  105 ++
>   Documentation/driver-api/index.rst            |    1 +
>   drivers/iommu/Kconfig                         |    2 +
>   drivers/iommu/Makefile                        |    1 +
>   drivers/iommu/amd/Kconfig                     |    5 +-
>   drivers/iommu/amd/Makefile                    |    2 +-
>   drivers/iommu/amd/amd_iommu.h                 |    1 -
>   drivers/iommu/amd/amd_iommu_types.h           |  109 +-
>   drivers/iommu/amd/io_pgtable.c                |  560 --------
>   drivers/iommu/amd/io_pgtable_v2.c             |  370 ------
>   drivers/iommu/amd/iommu.c                     |  493 ++++---
>   drivers/iommu/generic_pt/.kunitconfig         |   13 +
>   drivers/iommu/generic_pt/Kconfig              |   72 ++
>   drivers/iommu/generic_pt/fmt/Makefile         |   26 +
>   drivers/iommu/generic_pt/fmt/amdv1.h          |  407 ++++++
>   drivers/iommu/generic_pt/fmt/defs_amdv1.h     |   21 +
>   drivers/iommu/generic_pt/fmt/defs_x86_64.h    |   21 +
>   drivers/iommu/generic_pt/fmt/iommu_amdv1.c    |   15 +
>   drivers/iommu/generic_pt/fmt/iommu_mock.c     |   10 +
>   drivers/iommu/generic_pt/fmt/iommu_template.h |   48 +
>   drivers/iommu/generic_pt/fmt/iommu_x86_64.c   |   12 +
>   drivers/iommu/generic_pt/fmt/x86_64.h         |  241 ++++
>   drivers/iommu/generic_pt/iommu_pt.h           | 1146 +++++++++++++++++
>   drivers/iommu/generic_pt/kunit_generic_pt.h   |  721 +++++++++++
>   drivers/iommu/generic_pt/kunit_iommu.h        |  183 +++
>   drivers/iommu/generic_pt/kunit_iommu_pt.h     |  451 +++++++
>   drivers/iommu/generic_pt/pt_common.h          |  351 +++++
>   drivers/iommu/generic_pt/pt_defs.h            |  312 +++++
>   drivers/iommu/generic_pt/pt_fmt_defaults.h    |  193 +++
>   drivers/iommu/generic_pt/pt_iter.h            |  638 +++++++++
>   drivers/iommu/generic_pt/pt_log2.h            |  130 ++
>   drivers/iommu/io-pgtable.c                    |    4 -
>   drivers/iommu/iommufd/Kconfig                 |    1 +
>   drivers/iommu/iommufd/iommufd_test.h          |   11 +-
>   drivers/iommu/iommufd/selftest.c              |  439 +++----
>   include/linux/generic_pt/common.h             |  166 +++
>   include/linux/generic_pt/iommu.h              |  264 ++++
>   include/linux/io-pgtable.h                    |    2 -
>   tools/testing/selftests/iommu/iommufd.c       |   60 +-
>   tools/testing/selftests/iommu/iommufd_utils.h |   12 +
>   41 files changed, 6046 insertions(+), 1574 deletions(-)
>   create mode 100644 Documentation/driver-api/generic_pt.rst
>   delete mode 100644 drivers/iommu/amd/io_pgtable.c
>   delete mode 100644 drivers/iommu/amd/io_pgtable_v2.c
>   create mode 100644 drivers/iommu/generic_pt/.kunitconfig
>   create mode 100644 drivers/iommu/generic_pt/Kconfig
>   create mode 100644 drivers/iommu/generic_pt/fmt/Makefile
>   create mode 100644 drivers/iommu/generic_pt/fmt/amdv1.h
>   create mode 100644 drivers/iommu/generic_pt/fmt/defs_amdv1.h
>   create mode 100644 drivers/iommu/generic_pt/fmt/defs_x86_64.h
>   create mode 100644 drivers/iommu/generic_pt/fmt/iommu_amdv1.c
>   create mode 100644 drivers/iommu/generic_pt/fmt/iommu_mock.c
>   create mode 100644 drivers/iommu/generic_pt/fmt/iommu_template.h
>   create mode 100644 drivers/iommu/generic_pt/fmt/iommu_x86_64.c
>   create mode 100644 drivers/iommu/generic_pt/fmt/x86_64.h
>   create mode 100644 drivers/iommu/generic_pt/iommu_pt.h
>   create mode 100644 drivers/iommu/generic_pt/kunit_generic_pt.h
>   create mode 100644 drivers/iommu/generic_pt/kunit_iommu.h
>   create mode 100644 drivers/iommu/generic_pt/kunit_iommu_pt.h
>   create mode 100644 drivers/iommu/generic_pt/pt_common.h
>   create mode 100644 drivers/iommu/generic_pt/pt_defs.h
>   create mode 100644 drivers/iommu/generic_pt/pt_fmt_defaults.h
>   create mode 100644 drivers/iommu/generic_pt/pt_iter.h
>   create mode 100644 drivers/iommu/generic_pt/pt_log2.h
>   create mode 100644 include/linux/generic_pt/common.h
>   create mode 100644 include/linux/generic_pt/iommu.h
> 
> 
> base-commit: db37090502f67e46541e53b91f00bbd565c96bd0


