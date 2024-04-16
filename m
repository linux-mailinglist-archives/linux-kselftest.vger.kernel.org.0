Return-Path: <linux-kselftest+bounces-8170-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F344F8A6F6D
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 17:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21E361C212B4
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 15:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16FC31304B4;
	Tue, 16 Apr 2024 15:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YiHzryI7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UQGfwM99"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A80F12F5BE;
	Tue, 16 Apr 2024 15:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713280453; cv=fail; b=eGYhcKL6VzR+tUQWHBUR5x7ozzeSCJrcywj8KIlZKA/AIhsGT+ktxD4f5orlm3H6j3A7ys108PkqyOGaF5PjxoWFLZmoDoE4FUITA2hdTRQwLy1XHMQd/czVNbca7o2QxKA6LgHcIfXbuHcMKJyQ58TlyhcjvSkuZSmPjK8HOyg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713280453; c=relaxed/simple;
	bh=HNDVpUzwjvY5z3sgnAwBsz3a/WxAYZgRB+1tynWcvek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FS/zufaOmpQXVV5MwQvPZqINvNNk/expgeNph5KU+AVoF0/m6TqIZwO5rCMjIG2Pq3Ze/9FUNDpFjSB5Aljt2kQhPaqrKSVWDUWKUYce3v/fWrlyYmEubVDMO9vPdnt4UX1nh2m8SoJ/QRDm3GxLkzPDmHoE7FnscBni8ifZcvk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YiHzryI7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UQGfwM99; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43GENpZk027607;
	Tue, 16 Apr 2024 15:13:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-11-20;
 bh=TQmO+DXc9TKI09/fqXJDkfbD759mxA5h8VoTB06ePeY=;
 b=YiHzryI702n2/pZ+2WxpgL4zSizB5nOOnRCSm87kp1BrouO1Dwd+oIZsgtcaYIOh8Rtx
 cbY1G7Q4NlWVpDOu7+DBvbkb0Du5++1px1aJrstPwEpHkzMZ0YIo12LPUWDLKHi21V21
 YsrphGiY4F0uRSApocW8FYcEamQfyMOgqN+P9XejN1UbKmgb8kDlr4wDs7JOM7OislJX
 /ksGfjuxP9I3sDwk/cMlP6qKEKCexwi6LZ/7a/TUoN+c00ZgkHfYkfu7GOez5GJ5QAuz
 qmuvgrM6xReJ0QBYm2upsK82KEf8X+uX8XMh0lpQzv3aona8CppWFLnGkdU2DJbixhiA 4Q== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xfhnudk69-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Apr 2024 15:13:42 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43GExqTD028913;
	Tue, 16 Apr 2024 15:13:41 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xfgg7ccpg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Apr 2024 15:13:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VGdH846SHxM6EdFqq4VMnfndyrqqApATe1iuUhGF60zsyIb7rL/C+u+go8T++8Kju9EuTHn8ODknV7/tzGDUnMg7f6QE4o0OdFnIa0fBPkBr+FXlqI6CGYk1I3g0ddsE7xI2JbaeExqPHbfE1r/dyNEUqEjLdlzhMunsoIMGSLCaqR+VZ0qm2Dlbjd3XjK9OSEevJxg1GU//qvEjWZSifWm/e19xBQljlnrBHVsjPeXgdTPJ4hoab18uj5K8pOXA3/ercvUidoervDKFSd0lkui3H045IA4ST7QcGfU7oOro8NmpGXhQRix+o1q1YK1JiwbapN6H/M/GocufVpw8dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TQmO+DXc9TKI09/fqXJDkfbD759mxA5h8VoTB06ePeY=;
 b=lQB292NBZnyE+m6q58dIP+yBxKc21KhZ+WV5ljnFP4mGvXv7d8mfXgShfikbdbM+wn6WYEqSF7VeQLfTAArst6pZJyns8x4u2vGKCDrSSyv34lsophEVy7eIfBbQMg8mZ46PO/HRtaIyaqT7C+pvVW9CGfaZieZra8ZRzEQ+xsQ2BC4g2hT9DV1Nc/qfiOxJTw/pxQGBgFRzdjmgIKOMibl78+iDl7LoyfPFfDlZg9j/GTCqShksWE5Z3pTL/uj+vnjyjdFqnfiTrGexWvSiM0Y3GS4QyBGMlG5ESvrJV6IOQ4EDa4wugdGl/ZQR68UTIeOXg43JbMAWM2wb4Y+ZHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TQmO+DXc9TKI09/fqXJDkfbD759mxA5h8VoTB06ePeY=;
 b=UQGfwM99ZsyYlU8QDcFAKTtF4t/qY+7TP7/T6srzXUgl+7ptnUpEVC2EzCS9L9L9Uzt+IAm2TrhYmZXGc7yclGALRPf83TuhdHMRYBZ5VJfeEwbSGZzSy/7eIsiU9rDnD8z53rV91p3G4jagCEXPL84cNxNf1zmXBJ26s6QjykI=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by SA1PR10MB5823.namprd10.prod.outlook.com (2603:10b6:806:235::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 15:13:08 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::d359:1b95:6099:3550]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::d359:1b95:6099:3550%7]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 15:13:08 +0000
Date: Tue, 16 Apr 2024 11:13:05 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: jeffxu@chromium.org
Cc: akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com,
        sroettger@google.com, willy@infradead.org, gregkh@linuxfoundation.org,
        torvalds@linux-foundation.org, usama.anjum@collabora.com,
        corbet@lwn.net, surenb@google.com, merimus@google.com,
        rdunlap@infradead.org, jeffxu@google.com, jorgelo@chromium.org,
        groeck@chromium.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        pedro.falcato@gmail.com, dave.hansen@intel.com,
        linux-hardening@vger.kernel.org, deraadt@openbsd.org
Subject: Re: [PATCH v10 0/5] Introduce mseal
Message-ID: <znrbeb744774vre5dkeg7kjnnt7uuifs6xw63udcyupwj3veqh@rpcqs7dmoxi6>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	jeffxu@chromium.org, akpm@linux-foundation.org, keescook@chromium.org, 
	jannh@google.com, sroettger@google.com, willy@infradead.org, 
	gregkh@linuxfoundation.org, torvalds@linux-foundation.org, usama.anjum@collabora.com, 
	corbet@lwn.net, surenb@google.com, merimus@google.com, rdunlap@infradead.org, 
	jeffxu@google.com, jorgelo@chromium.org, groeck@chromium.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	pedro.falcato@gmail.com, dave.hansen@intel.com, linux-hardening@vger.kernel.org, 
	deraadt@openbsd.org
References: <20240415163527.626541-1-jeffxu@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240415163527.626541-1-jeffxu@chromium.org>
User-Agent: NeoMutt/20231103
X-ClientProxiedBy: YT4PR01CA0333.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10a::21) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|SA1PR10MB5823:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c5deb87-54a9-4704-88f5-08dc5e27b8ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	sGr+0R8Vjc2DE+0OY61dlGl3IpFRIq0wdsYrQd0u3VIr7ooPLsOHH+vQVEIUpMf1ykVWHYkjWcppgplx7zD+9BTW9Sl54/m3zDzaZqw+uNTnCKVeyAmq7Zu9DT14skAmIIL/QcxS85lsRSqrVn3V6hF5sFD7d+1Ca32dxxpZaag58AD6lC68Pb2R9PoW3QyJjc/ZcnqeI/r2XRY2K0O3ApZDZldVeY0TBimB/GKFzec164xq6tfImZnVYJZOUsD8j5zIPFmxPCDUehH0Y9y8cd5T6LK39N/tf8pFcfuojYTfT598w8eEI86TXgiaG1bQeylDS37ia77abSKZVMJiIAVNHVJd9A6FuRtfVTR+NzCd+sDltNw8cAVuqkLRj+7YMc6Wnll5KPg0gUAlyfAfhN5HyrmhXrkMu8irGzS3CL4GG5VZw2WNr6pbMDE6HAIRO6R42F1pPdPi662NItn/CkUnQcnGAv/TcIESlsAILuhHHDrjZ9IYCi5Qkzh/2iBh2PI8e6sDpkwONGzuzyWJXv1PSaR5tlNSI65ly2qCTWBrlubGPBd84jXk6I5Kp9c9MgV9/jwBuA4jYtfQQh5zn69+0pCjnKHImwJLW+gW8JoBiDyOPqo7bCv2GKJexbhJD6PVnyb13XuoDlkOwTp3rdAgHDOaB/ArChoUC27ZpRA=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NnhESTd5K2dIMEUxV3N0WlA4NlhER1JCM3NsMVVWd1ROaWpwcEo1TnV4VmpT?=
 =?utf-8?B?VjZ3RmpBcGFQYjB1QnZycFJkMGxrWkNyYmtQSVFrWWNjeC9qWXFqWVBuclZV?=
 =?utf-8?B?YXk5R29HbGdtcC9sQnlkazVTSTZpWEc5R09kTWkzRFBGcllRc0l6L1lGOUxn?=
 =?utf-8?B?RE1ZUFdjVFFzN2N2WmZTWXlQM3R4OHhqaXllQ24yLzF0WWdjdHhTeGxQeWFP?=
 =?utf-8?B?bGN5OW9ZRXROQzZlMWNBWlNGWlhkYzNQcUV0QlNhdm4rejU2UHdCMXRFTGxO?=
 =?utf-8?B?KzVSdXJhUUttRUpLVUFPcTBMUG90Tmt6ZFZiYlBoZzcveXlSYWF0cUt5enVG?=
 =?utf-8?B?dExjQkpCVi9ZOS84SmRvaThyU0JJS3VmTFNFMGhXVVVhYUxObS9sMW1SQ1FM?=
 =?utf-8?B?NnN5TGo0dUFtNmtTd2tHZUhkRVJRQlB1eitkVnNQRWwzUTdYVy8xbE5yQUU4?=
 =?utf-8?B?Yk5FdG1pZ3Uya2hSRW1xMnllekdFWlk4T3RqZU9hWDFDVE5ZQ0pqa0JnSWRV?=
 =?utf-8?B?Sk5RSWNsMXpWWW5RSFl0aEpuYjBpam4vVWdOQi9LTnl4QmlIcER4a1FMaEdh?=
 =?utf-8?B?UXFpbXFtcHU5OUphd0hjVnY0QUh4SlNzWEhHL2N5cG9DUXIxOG0wNDBZZzdH?=
 =?utf-8?B?SHFJWCtzYmU3blV3WERESlQ4V3UxUVl0NUk5UFV6bFhtSS9KRjdLWWh3azYv?=
 =?utf-8?B?aEsrbEJhRHlNdDBucHQvT3llNTBNT0lTeEp1am54eFZmT2hsQVc0S24vS1FQ?=
 =?utf-8?B?OWF4QkVzRGFYRktRQWJ0aVhsbHViTTZVUGxrMDNTMmRKUkUvM1VNNDlxRm9u?=
 =?utf-8?B?VkVhbVV3MGtPbnZ0c2ZDTlF6aUtOTVEyazB2dzFnRUszZkg0UjRWa0F1NWpt?=
 =?utf-8?B?djFKL0dJK0piQjg4KzQvc3IzSDlJNmJtWW9sYmEzMkoremJxeEF6MFRGNTRv?=
 =?utf-8?B?TVFyL0J5YkFsWno1NzNIVjBEV2dpRmUwalQzeWl5YUJldzNTR3hrZHhuV1dD?=
 =?utf-8?B?NldCTEQ0ZlBjZjFXeGFpazgwOVlSQVlIRjJkak5DUUJSSjMxWXR5M29EUHhH?=
 =?utf-8?B?RlhISnRuZEdQekZWaG0rNlJrUy9qQlA0L0hlK29qRGx2RjhXRGhVUFQvdHpC?=
 =?utf-8?B?TTNkSlArZEV5MkJaUDMveTlKclRZOW5jSXMxcUJIUTF4NUwzVDRkMUdyNlJu?=
 =?utf-8?B?dW5oWkxwUzlCV21ncWZZMVJnL215bU5ENnVjL1NiWjJsQWk2TTNLaFpTNC9q?=
 =?utf-8?B?OUU2NXc2U0k0RkFBUGFnS1BtZVlyK0pKaktob3BCdkpIVUZqQnZ3YVhuS3Bv?=
 =?utf-8?B?dGVyc1UrenVpRlFyUjJTTnI0M2ZHNHBhclNTNVFLSkFjSGdPZERRcnpBeEdD?=
 =?utf-8?B?Wm0raG0yRjYxTHlPeW5mbGtNQXVWZ1B5b2dHd2xXVktJZWp2VVNDMEhuQUVp?=
 =?utf-8?B?QnFOcVh6cXJwakY4alcrbmlRQzF2TzBFUnZuZ0ZNWWgwOEtoYnlwNjdvVDdV?=
 =?utf-8?B?ZEl3dEl3ZEZKcTFtSkVaem9yNGhmNnR0QkhwakhMWVZPRDhWNkxPNGtTdnhL?=
 =?utf-8?B?VWVmMitkYWlEOUVnTzY5MjdmNWJTM0lTUWVVMnVDS2Q3bW1QdEZ5TXhJeTJI?=
 =?utf-8?B?a2ZIUUFZTUxsVDRJS1Nlc1RVcUlKQXFNQzloMk5EU0VVUmt6RkZyZXJSSDEz?=
 =?utf-8?B?QzMwY2NOOVFvODNGSWo3MUxpeDhjOUIvL2Mxb3hjc3JnRi9aTURNVUNWU2pI?=
 =?utf-8?B?VktKTVBJMXdpZ0FONnVweXZjTktocEFGY2JIclJ4WHl6cnRiUThyeXJKNnFO?=
 =?utf-8?B?c2pBSHR2RjNBbm9wMjJ2endCWVdCcWYwRENoaDJIVk8rVTJuT1hhNkdVYnZB?=
 =?utf-8?B?d3lSRVhhQmpycjNyZzB3dE9mUzdtRlZENnVoM1NCSGg2MzFLczBSRkFmd0xS?=
 =?utf-8?B?cjZndTNPb0JJODVMZUcwSnZvYUNPL0syeVNPMForeGdsVitvYm5QSUJxcFZ6?=
 =?utf-8?B?SlRkdFNaRE5jN0pNNnVpWENENVh0Y1BhRVhmV1dZMWwwMEV0clhtbGQ2N2l4?=
 =?utf-8?B?cDN3MDVqSXFRMyttaTJieEF6MnY4VmVTZGxVRFNrSWpOS2I5ZEExUTJpVmJa?=
 =?utf-8?Q?yX4GRod2Qq+PM6fAGagtKEf/d?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	TnZD/TJk/R8Y5JarYIx9DqttAPJgWhqjWzdcSRlxWR7SVg2dzlCd2vFUW9EZokuEN9kRSgnNV9iFCrWQ44oKiUalYquyIQkW1GjT/CClRpP/pooxAHDhYWNS4Vox1Br3nwF+Ebt8Fb731hLez2i3s5VzpJDR1MVdlEBU9zDCuvWX3fyjpuArEpN/aB1YgEOJJanCXRIprF11D9aEPNT2TQnwqXPABkw39w88Xoc/FP1xaEztixBFqECUg5N5MhVYkf3E/2WTWt3Kuwhfy4lD/RiZa8Virli6/0WRebGps4a49JrbuUnqUGmcICeY7Y9U6G5B80zGWPYhX9NN34jhVcv6HNhf14roTVPZ7iXGs+VvldiOgpobm72IXDaj6BdcZ7gK9BthTqOLT8NyBuek7WE/QzzwPFOrUTabrWP6XJdX4+wi1/D48remiVFAh+oPST8GGx2C+QGjo82uGlOKpmGxmpgTySIHbBK00PNsnLoyj/xKTiQ82Qd9zfXUQypLLfRKDm+a4CVDkxFUg0kCObCy1jjuA/8e00BK8zgCJcnnTYTkPWF48sqV9Ed4LvkDqwJ7//bmi2kQm1VEGrptwWJjE6cKkRV1LR40CK+/2hM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c5deb87-54a9-4704-88f5-08dc5e27b8ea
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 15:13:08.0290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Y7VYuY+HEjzEYx1ODzVWMBl4P/bYN5tmnEGpCaB54poQ4eKuyq0OtDSc8jF1l0qNmjT6BuXZRbR7372AhyeSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5823
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-16_10,2024-04-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxlogscore=999
 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404160093
X-Proofpoint-GUID: OkIYY4cD1lR1GJs3U7WXLzM-DKM_1j9t
X-Proofpoint-ORIG-GUID: OkIYY4cD1lR1GJs3U7WXLzM-DKM_1j9t

* jeffxu@chromium.org <jeffxu@chromium.org> [240415 12:35]:
> From: Jeff Xu <jeffxu@chromium.org>
>=20
> This is V10 version, it rebases v9 patch to 6.9.rc3.
> We also applied and tested mseal() in chrome and chromebook.
>=20
> ------------------------------------------------------------------
...

> MM perf benchmarks
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> This patch adds a loop in the mprotect/munmap/madvise(DONTNEED) to
> check the VMAs=E2=80=99 sealing flag, so that no partial update can be ma=
de,
> when any segment within the given memory range is sealed.
>=20
> To measure the performance impact of this loop, two tests are developed.
> [8]
>=20
> The first is measuring the time taken for a particular system call,
> by using clock_gettime(CLOCK_MONOTONIC). The second is using
> PERF_COUNT_HW_REF_CPU_CYCLES (exclude user space). Both tests have
> similar results.
>=20
> The tests have roughly below sequence:
> for (i =3D 0; i < 1000, i++)
>     create 1000 mappings (1 page per VMA)
>     start the sampling
>     for (j =3D 0; j < 1000, j++)
>         mprotect one mapping
>     stop and save the sample
>     delete 1000 mappings
> calculates all samples.


Thank you for doing this performance testing.

>=20
> Below tests are performed on Intel(R) Pentium(R) Gold 7505 @ 2.00GHz,
> 4G memory, Chromebook.
>=20
> Based on the latest upstream code:
> The first test (measuring time)
> syscall__	vmas	t	t_mseal	delta_ns	per_vma	%
> munmap__  	1	909	944	35	35	104%
> munmap__  	2	1398	1502	104	52	107%
> munmap__  	4	2444	2594	149	37	106%
> munmap__  	8	4029	4323	293	37	107%
> munmap__  	16	6647	6935	288	18	104%
> munmap__  	32	11811	12398	587	18	105%
> mprotect	1	439	465	26	26	106%
> mprotect	2	1659	1745	86	43	105%
> mprotect	4	3747	3889	142	36	104%
> mprotect	8	6755	6969	215	27	103%
> mprotect	16	13748	14144	396	25	103%
> mprotect	32	27827	28969	1142	36	104%
> madvise_	1	240	262	22	22	109%
> madvise_	2	366	442	76	38	121%
> madvise_	4	623	751	128	32	121%
> madvise_	8	1110	1324	215	27	119%
> madvise_	16	2127	2451	324	20	115%
> madvise_	32	4109	4642	534	17	113%
>=20
> The second test (measuring cpu cycle)
> syscall__	vmas	cpu	cmseal	delta_cpu	per_vma	%
> munmap__	1	1790	1890	100	100	106%
> munmap__	2	2819	3033	214	107	108%
> munmap__	4	4959	5271	312	78	106%
> munmap__	8	8262	8745	483	60	106%
> munmap__	16	13099	14116	1017	64	108%
> munmap__	32	23221	24785	1565	49	107%
> mprotect	1	906	967	62	62	107%
> mprotect	2	3019	3203	184	92	106%
> mprotect	4	6149	6569	420	105	107%
> mprotect	8	9978	10524	545	68	105%
> mprotect	16	20448	21427	979	61	105%
> mprotect	32	40972	42935	1963	61	105%
> madvise_	1	434	497	63	63	115%
> madvise_	2	752	899	147	74	120%
> madvise_	4	1313	1513	200	50	115%
> madvise_	8	2271	2627	356	44	116%
> madvise_	16	4312	4883	571	36	113%
> madvise_	32	8376	9319	943	29	111%
>=20

If I am reading this right, madvise() is affected more than the other
calls?  Is that expected or do we need to have a closer look?

...

> When I discuss the mm performance with Brian Makin, an engineer worked
> on performance, it was brought to my attention that such a performance
> benchmarks, which measuring millions of mm syscall in a tight loop, may
> not accurately reflect real-world scenarios, such as that of a database
> service. Also this is tested using a single HW and ChromeOS, the data
> from another HW or distribution might be different. It might be best
> to take this data with a grain of salt.
>=20

Absolutely, these types of benchmarks are pointless to simulate what
will really happen with any sane program.

However, they are valuable in that they can highlight areas where
something may have been made more inefficient.  These inefficiencies
would otherwise be lost in the noise of regular system use.  They can be
used as a relatively high level sanity on what you believe is going on.

I appreciate you doing the work on testing the performance here.

...

