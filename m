Return-Path: <linux-kselftest+bounces-17357-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BBCFE96EAEC
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Sep 2024 08:47:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 216ABB215DD
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Sep 2024 06:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC03314B953;
	Fri,  6 Sep 2024 06:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="XJsURGsd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56EA12EBDB;
	Fri,  6 Sep 2024 06:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725605163; cv=fail; b=qQWPN3BrxS58Ehb1HeSVo7i/WFSW1XARosJyhHj7zduDTb7oWjsmknTlUfNB8VjQn+O8qYq2hIXk7X20hipixHqTe1UuYRjL7PrTwxJqA6DTmlrBD55Lc0Rr2EOr2Qq84r1Oq3V8ZMHAY71ZhP/Eah0XUnCXMume0UWM1yxyyLU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725605163; c=relaxed/simple;
	bh=1Uj8vrXBY1oC2PavA+smzJ8nQukBU86FTVNHNiJQYdE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KW1KLWLHaqht+aieSYLy8lghvF1v6HsTi/q6yvrhE74QnF3/luJ6GLvLxtao6Z+IoLu4dnhdQ4GECYEBQldV8jtNUDmHLxI7TJXnIoVQ7pKctfSp//uqFZQodlPZlSyUJOde3YOOLbL0mGcTq9vQw5BGwaNN7Dz3WJsrskky/jI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=XJsURGsd; arc=fail smtp.client-ip=40.107.223.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=axKcdUQLJ7YNDl/TSXSDaZpOWwYHtdlVyMbCByl1KP4PqjzYvVk0kTwh3ifCrgJb42JfoEqY9oyiRjWaDEffc44ZrmSqpXcIuFdIJxTPY8bYB2gDsqQ3xRHVqu9ezHE1rXEh5cptpom13WmzY5QPxJ5PIE9LmolXi1NaDaJ2Jpot6yxv7P8aCCdVj98QH56N9C58EJgbNFBC9wvDhCgFHxcVcXKjMU6iuJMwshpC3rfkXc/UHSG07kwX4dbOBBeMDlk0zvkTipIfuaPIQGXYouXhEaq9tNsK5Tt+r4MMCC64HXNPUvqvxKBLrMWBoFP/YHKVwoIKGRnjm6jINlTPsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hU94wP4kJrBEvHKQmbtfo79jPADGDVBZbjsTMDtsCFI=;
 b=RlQIufxfdEd1WMeaJJ85wA+NwSW49pcn+2G6euFp61vwogW1bcuiUQfZRBgEW2Kzr5Dc9AG/LARANvKCxPGL99w9MyHUnjhZUpywLwmfjyQQ/gE0EqyzGBQ1RMQZCBcn/YLedK2tagglToEATUTHc2hdG/q2xVQeMn+lwm/gLawLmpsB/BqoT+ajgSpRcTpV35/PI7FCeZuOuqOtWZOBPKHRzMBNQDYjN7jmfkEQ6s53bVb7HvU7AqRoGhnjMf3YMepwB5fHosGXXU+uIb+vDXSajzchSrKBqFHTDF2/V37GuFppXYNIrft6rcOVNtJgnT1T0piAPdni82F/zQHrrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hU94wP4kJrBEvHKQmbtfo79jPADGDVBZbjsTMDtsCFI=;
 b=XJsURGsdYCSxwN7Kvs6OEuZeroP2k8zuPg3fXmIGwEVI/fEjTm/wPHw3XSus9MgAnWbyL1LQTQ1W/qRA2yxxz7F/Qw5dYQUnQnenRw22q4Dgb71DsinAjCGeqhWHm/kdEKw6I3cJqsa5LZbvW7vSPee/HQ1CnAn7Mv4K9BQnm1S/g5ptWTegePRX/g7L605swRPeLOsWQOyNnrR2gm1nQ4Ulbz8xZYgekL/OHQ4UCttZcHZVHHSCdfPsfvMOUhXzHQX4tL26MDYQasl5w/gsOInT9EZ0mETceZX6p+a7cuTITLqt/NHlf0X0ePiJgnpbsHXb2ElSeBG/+G7xzYhQ/g==
Received: from DM6PR11MB4236.namprd11.prod.outlook.com (2603:10b6:5:1d9::20)
 by SA2PR11MB4780.namprd11.prod.outlook.com (2603:10b6:806:11d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Fri, 6 Sep
 2024 06:45:54 +0000
Received: from DM6PR11MB4236.namprd11.prod.outlook.com
 ([fe80::ea6a:8f25:ead5:8dfb]) by DM6PR11MB4236.namprd11.prod.outlook.com
 ([fe80::ea6a:8f25:ead5:8dfb%5]) with mapi id 15.20.7918.024; Fri, 6 Sep 2024
 06:45:53 +0000
From: <Mohan.Prasad@microchip.com>
To: <andrew@lunn.ch>
CC: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<shuah@kernel.org>, <Bryan.Whitehead@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <edumazet@google.com>, <pabeni@redhat.com>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<horms@kernel.org>, <brett.creeley@amd.com>, <rosenp@gmail.com>
Subject: RE: [PATCH net-next 0/3] lan743x: This series of patches are for
 lan743x driver testing
Thread-Topic: [PATCH net-next 0/3] lan743x: This series of patches are for
 lan743x driver testing
Thread-Index: AQHa/olXajpx37qPH0O72SAJQKbczrJHGf0AgAM4JXA=
Date: Fri, 6 Sep 2024 06:45:53 +0000
Message-ID:
 <DM6PR11MB4236D1B92E9FDF1A4640DA68839E2@DM6PR11MB4236.namprd11.prod.outlook.com>
References: <20240903221549.1215842-1-mohan.prasad@microchip.com>
 <7cbdcb2b-37d8-45b6-8b4e-2ab7e7850a38@lunn.ch>
In-Reply-To: <7cbdcb2b-37d8-45b6-8b4e-2ab7e7850a38@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4236:EE_|SA2PR11MB4780:EE_
x-ms-office365-filtering-correlation-id: 0fe19ba8-bfac-4d28-a24c-08dcce3f8d99
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4236.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?4VqSrHoMorqVdONUZZzcD2/GbN/o5In5SGxxQbBQw5c0MHDtDuQGo5rMO7xc?=
 =?us-ascii?Q?lGKf5gqOjOcOoVyjJwGnp2RbdWHvfdRMQHb6JbAe3YB/zF1ZFCrL4wDRTXAH?=
 =?us-ascii?Q?pOx7IC2+S1iZnFCdj16Gp7exRoCMRZnpzRGJFbmy4EgvC/9mhDEqBSyd0Jju?=
 =?us-ascii?Q?ueqYqaRPYnY2MEe+0DbCQYKuPz1DZY6QStJsseb5dpapVMgZmsmNbFPvnT+b?=
 =?us-ascii?Q?opApeit/eTwBGIYXv1/VEyXLpTy532RXZRYBUSAkKcRmg2S0PodZi4165M8T?=
 =?us-ascii?Q?D9LMTKmMED8oLujhJx5NQ0YQv/UELt68Zsegi4hLLXegILAPeUHZlry/n1oN?=
 =?us-ascii?Q?6f+2zs+mEKElpmA/W9t90X6YX5I8uD7pk5I6lDjmtTjMCgON+mrK6cr3s7ur?=
 =?us-ascii?Q?+H2/CPMiO9lTQZcMsd4VDnU+YJkv8usbhtNP9Cv9nAQOV5whl06CCk0pk9L6?=
 =?us-ascii?Q?fDOMuuA3Xxkd7S81zh0marN9T5QTfi8/J8kyPwbKSbAeo0wZKd0IdNg7p4Xl?=
 =?us-ascii?Q?qPzvyvUbdBSDhpnQoPateM4MkccWg+fQw1MwH8cBE7LqYSIh7YFMF6sYYnga?=
 =?us-ascii?Q?8jlPiY5dYJfc/tD2cPsQ8oSfAyDmkLBIYeGQ1vI1jWXipN3/0DM5j+yvNt6X?=
 =?us-ascii?Q?KeA0o69+Ts+BSTmBa9emkHqhcDJsCN6zNCq2PWaA5bp/Nyd3BfA4Y74Oamaz?=
 =?us-ascii?Q?alVnN71JOQstSmpchiBGPybGeFNprTNMahMKyIdOKIk+/yW4UU2FsWyDxuvu?=
 =?us-ascii?Q?kcXvFj1Ym1TtrRCXeYAAaLTIh3Gn4ofhUTyO2BMfJtrQqdo2rKA/hAOOHuy/?=
 =?us-ascii?Q?MhKZIDh2qKDiq4pfTKFt+lWv94xDbdb+e0m2NmC+DEBR2A6Lqbg9BcroliE9?=
 =?us-ascii?Q?WlJwjbIagAAfT5T2NDxLDIgLL8DaALvRbPRmepcqIisRUWfd4luf6QIs6PWS?=
 =?us-ascii?Q?zAKkp8ex5NdAUzd7OddRNoOCfgJ1/Vusyv2pvx+saXzmjPLzxrZgjCjhos8q?=
 =?us-ascii?Q?8sAnlNnPam4sI+tsQ6VJa+4AGDtN5sqQqKyYzazThWs2LYDirSPdKdnACF2f?=
 =?us-ascii?Q?kqUG4HnO88Zglti4bSqzXjXedzqQDxIyEC1iO5++M58Bt8Fi7hCv7Ko1dt35?=
 =?us-ascii?Q?Ku6ECg7oSrFVfH6JG1RhSNEO68EAPLIR+fgstxvrKCGQpMwxWDrBP9826kZf?=
 =?us-ascii?Q?Fq6gQOl1MRbgNiyF/ZfUPbYA7DF+aa2eIe8Px43MKggBbCqNpZHxfLns0S5Y?=
 =?us-ascii?Q?ZO9xALTXnMTuBMdp3uOt+IFr684pKL0XDL/Wje1xb2EWQdYmz6ILJCNZqIyl?=
 =?us-ascii?Q?vPPlufpy9nw/+T0tBs7/kbO0/3owYRbqgjemNyslyepeyaugsfzIdr15A25g?=
 =?us-ascii?Q?WdOx6by/ZvjZLGzeCw6WapUKyRds+9kgtesXOZFzywlWzsnVRQ=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?DDoS16HUTEHaN7ZREkNaZc3ge91NFc2zp+9aA3pvZ4war+C9+/Uh2K9W7Cn6?=
 =?us-ascii?Q?gWzzwVTFOgDa/pIgQYADrsNQfV7f1ZZkOqo8g0qxgYvXrpX2neR3PvDFeikp?=
 =?us-ascii?Q?9nQjb430fvVW85MZw7/V0hJBtztRrgKGysVL7KByTZ+TV1zE2JIt1otBXCo5?=
 =?us-ascii?Q?fXd6onFn0UmNKMtphLHDq+UNWhUfeO9EeiurAFD9drzruLNnVcLkGbPBlOwU?=
 =?us-ascii?Q?Rfxo7etnp/kb5gL8VH6XLiDpHmg/Y+U1dPactj9BOD8FiL6b5I3mLNNwCPf7?=
 =?us-ascii?Q?ZdK1CxCB+TxcjlyNKgGHG1bofj57AnN7DMOMdDAqeo7CAMZdehItKEjcnrrC?=
 =?us-ascii?Q?7nZr1r/0ojS2qONdgJM0SEKX9MV8MXYVMp30ZzVb3MeKmDQKZmLlqEPPBJIp?=
 =?us-ascii?Q?MUfUpt3e6EYFdR2Onb9wkeviDKu0/+cpWXjOQH2FYnsCLZNBHGY92FA1nJmF?=
 =?us-ascii?Q?9KPn1mpPelnRybFFlwqPHjMTTDCGe9xonDSIvyidT1O7t9XqbRH3lj/Ez98o?=
 =?us-ascii?Q?7FZSl5kUATNRPX9it4K0hxeDeIGrJYSUkvfZzi4pPx8GeI4IRWxhk17IcfH/?=
 =?us-ascii?Q?j9SH6KvClZRRmFfiOOU6NyggSfgTXTSb17CbRHZkLTPB3aSTga/ORy2BHj6B?=
 =?us-ascii?Q?q3AIxQWss+25Zpqci/3aQRUI9iqW7nkndYbBlC0C1whLXf1xht0PcnUgeNX2?=
 =?us-ascii?Q?D10N/tlDEbAe8Vlu0HZGANAFuHSk5D8A+80xG0NYiR0OCPElVrtEEckvItuV?=
 =?us-ascii?Q?KND1N0YlSesrre/kKnUQ5uFB9wJcyPrjcp1HGeS69GTylMRAYPpds7sgbANv?=
 =?us-ascii?Q?Rk/1xvmdjG2jp7S225qMObe3N3wOdNdvMTfdvScNCCpt8R4aA49TW3OFNSjD?=
 =?us-ascii?Q?VVf4Qx6YShT9XasUjgG3OtOHbd7kZfWxiv6PPqrXJa1e0ICejpLtAqKxEpDk?=
 =?us-ascii?Q?YRz4wIVDgDrIzuDtwJU7e9S0AF/37V3b3Eg0j+d4l/AahXnHappy6KXMYsBk?=
 =?us-ascii?Q?uKa+arag7JAgR228AiD+f9MRKydAO5lVHjjK4+6cKL2o+DZWA3xbCyIeXl1L?=
 =?us-ascii?Q?3JPxiX0Ln+3+Z7feKOQZOay1qxjpK2JjfwUaGOmoExRr6m8js/RSEEOoEnRF?=
 =?us-ascii?Q?Xv2j9OeptOx+Do7eEyDotmmOaZ7SzTq8LkV+Y0GLMX2e0sKaznU+oJGWpwQp?=
 =?us-ascii?Q?tV6xfcmxNIBJnal0WZc2Lr2R5v7/6Bkm2FwAdq8vEoEIC0VdxbAogGcjPzfr?=
 =?us-ascii?Q?FxtoqcndrpgQi95KiFm8PnmpPc2oIUGdCZyUktta1H+k+x8X+9PX+qfNm3eJ?=
 =?us-ascii?Q?pfW19TVqSdNVVzaOe/qBmGEe9gIkmUZq9my0FhZfmBSjNez5o2ShMC46/Xgo?=
 =?us-ascii?Q?MaA5jZgO45/Ehc708cRWZJx9GxOCgeMYSZfnYR+2OK8Mz3XLm7862yXp4L5c?=
 =?us-ascii?Q?k1G+0gAP0fryfVpv7rm+srC03dcXLop/DHzxw63sIjzkxqXd/cXfkYH5zjYk?=
 =?us-ascii?Q?+3+5NBoJClQpA0SWZlUX9MZRrGBIdRBOmT7VEQSc0vZEM30HUhv060x4eq8l?=
 =?us-ascii?Q?igo7EtwKKP6p5kQcL8Mjy3XjDk4l0cf+o0ID56SZ8dAPJcBZj6BNlHHEtYEq?=
 =?us-ascii?Q?lA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4236.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fe19ba8-bfac-4d28-a24c-08dcce3f8d99
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2024 06:45:53.3077
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: izszdCBcq1h101eCuRchcW9QhQTfq+nrcmTO34L7F3fz7zB/5ol4bqS6GXnNjjtZuOg5yv9gvW8+y4/cRsgzWHsRuYRFzfLJdc8auG1zpzM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4780

Hello Andrew,

Thank you for your review comments.

> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e
> content is safe
>=20
> On Wed, Sep 04, 2024 at 03:45:46AM +0530, Mohan Prasad J wrote:
> > This series of patches are for testing the lan743x network driver.
> > Testing comprises autonegotiation, speed, duplex and throughput checks.
> > Tools such as ethtool, iperf3 are used in the testing process.
> > Performance test is done for TCP streams at different speeds.
>=20
> What is specific to lan743x? Why won't the autoneg test work for any
> interface which says it supports autoneg? Is duplex somehow special on th=
e
> lan743x?
>=20
> Where possible, please try to make these tests generic, usable on any NIC=
. Or
> clearly document why they cannot be generic.
>=20

As suggested, I will change the testcases to generic form and document them=
 accordingly in the next version.

>         Andrew

