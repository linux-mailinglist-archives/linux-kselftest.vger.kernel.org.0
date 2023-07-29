Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD3D767968
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Jul 2023 02:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235888AbjG2ATz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jul 2023 20:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235876AbjG2ATy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jul 2023 20:19:54 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 203812680;
        Fri, 28 Jul 2023 17:19:53 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36SLied2009891;
        Sat, 29 Jul 2023 00:19:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=X00wGb8GHYojr6IP6r5RfLhvyG/76tFT0sYj7DmIQfY=;
 b=aFyD63d4rGQxxvqhTKU5Fv5FsK5RFdzQPbt1hkWkKWMaA5JjXcKLO5v1yv/jfQy3C2Po
 dT3f2QA5BKtCfDy7xRkW5JHgnro6stMccbFhyiC20DXu5QiINbwHSeoZs5fjDvrAPa2z
 QgKikUL3Qo0Xpq5MC4+eW/YDQ4aEYcgvSeij+MQGgpeTFuA3DH6gwX970GM7uCwLqB7C
 uoiy+xCLnJsG/gQ+VUB2pcD6nL0Rotn79rL/3cTZERDoCrnOhpkfjjshiURoQNkEarK+
 jHKEFknbrImGMOuJwIkbSjLckuKvJHck6ziCMPwsC2XksF38SSMrXrpu+SFMrPRl+oJf jg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s07nuvw52-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 29 Jul 2023 00:19:47 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36T03mHY030480;
        Sat, 29 Jul 2023 00:19:46 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s05jg3he6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 29 Jul 2023 00:19:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IuMPE3BuADpnYbF2BlQHszc/ooivE1Hl5vyxCIpo6fYPLn0vdyW6gV2fkMjApixtgBLLPgz/+a29JxpVduHdl8Ub+7FHP+ufFW0nUwijzV6BNyKn/vnM2MIugHQ6qyDcJ1zrzs+/TOcoD80feFzaWA6UhXBccVMavUpuEccEeEirsw17nNz8Brnm08a9eH+JMQUO+5quxWxxIAPLfgElOlscWnHY33LpfcoNRCqmmG6FKF+9FGiOqCfTr8BZYe4e7a5ofAaC9ihDTblhHz87BxHCX8E2VR/KL7oobsjYk1VbNVjDG2dRpi1paTdv/0QvEK2npeRoqdgoFJUZIBfYRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X00wGb8GHYojr6IP6r5RfLhvyG/76tFT0sYj7DmIQfY=;
 b=mycxOAD4tG9RGQJyc6aV0HPTl3gLrxBf1juOWA/fLDRTFxDAPetU8pTPiLfNriixVzk1/lb9ZzT8a0Do7pwCQRIQceXUqG4dalP0qsrrag5NzXwFJVPLVw8o2N605/vmwGF/5ZVovYfWFAW6GocpaYn9PWzfdelqpQDmw4y8xsA3ixHe/ixBQzENmSsLNVpr+UMivlSqo5fyqOwb9CkPpLqp7DTmTfdaTshCbi2hV394a98HvJ9S6UCclIPgpaNMQBD9uLHKLVlhZXQDHt0swCHzU3PjJ+jo/6NZGTdAArgNL77EFRQSIg91/2lkCBPEGc5TKyAKqdzcrZ+mdRMIyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X00wGb8GHYojr6IP6r5RfLhvyG/76tFT0sYj7DmIQfY=;
 b=HEfQvW7k6uukHXyula7QhkjbshVobnR727GLDBPu0uXSanYDsSnKI1xV7D8ro8V/i7DJ2Ha/W+aD+Oui+ufUGvTPLOenWaFTO6SvGTXZruuPK9+d1XE1PitDKkRNQ4EaYGnVk/1Yovlmt6znB3g4RfyK1e+mYgoM7VIybSMy5/I=
Received: from BY5PR10MB4129.namprd10.prod.outlook.com (2603:10b6:a03:210::21)
 by LV3PR10MB7747.namprd10.prod.outlook.com (2603:10b6:408:1b0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Sat, 29 Jul
 2023 00:19:43 +0000
Received: from BY5PR10MB4129.namprd10.prod.outlook.com
 ([fe80::69d6:8729:ee7c:cc45]) by BY5PR10MB4129.namprd10.prod.outlook.com
 ([fe80::69d6:8729:ee7c:cc45%2]) with mapi id 15.20.6631.026; Sat, 29 Jul 2023
 00:19:42 +0000
From:   Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
To:     Shuah Khan <skhan@linuxfoundation.org>
CC:     Shuah Khan <shuah@kernel.org>,
        Liam Howlett <liam.howlett@oracle.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH next 3/3] selftests:connector: Add root check and fix arg
 error paths to skip
Thread-Topic: [PATCH next 3/3] selftests:connector: Add root check and fix arg
 error paths to skip
Thread-Index: AQHZwXkWbDEKB7ogokq33I6v8z/kP6/PesIAgAAPagCAAAqwgIAAGwgAgAAFxYCAAAT4AIAAB1+AgAAD84CAAAWZgIAAFj8A
Date:   Sat, 29 Jul 2023 00:19:42 +0000
Message-ID: <C3669401-536A-4CB0-80E0-5CCF2DCC36D3@oracle.com>
References: <cover.1690564372.git.skhan@linuxfoundation.org>
 <2c0ac97f9c8e6bd46b60854c136099c0dd4a09f6.1690564372.git.skhan@linuxfoundation.org>
 <0CB227BA-69FD-447F-BE73-2482A6998F7E@oracle.com>
 <5b283f3b-f176-7f19-5db0-1332a94a44be@linuxfoundation.org>
 <ec809279-cc41-7e0f-a567-29400b4c34a9@linuxfoundation.org>
 <16B47831-5F53-4BAF-B347-A1404D2ED264@oracle.com>
 <957be0e8-2bdf-80f4-92b7-3b9070c546b3@linuxfoundation.org>
 <3242346A-9B09-44F7-A062-8456F83372C7@oracle.com>
 <84048d13-9311-36f6-9eb4-8169952580d7@linuxfoundation.org>
 <AD8D16A6-63BB-4953-80BA-6410B29416D6@oracle.com>
 <8c92599f-fcb4-3aba-f367-17abd9b52451@linuxfoundation.org>
In-Reply-To: <8c92599f-fcb4-3aba-f367-17abd9b52451@linuxfoundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR10MB4129:EE_|LV3PR10MB7747:EE_
x-ms-office365-filtering-correlation-id: 145b06dc-5cf9-4520-3876-08db8fc981a3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YG2UU+qhYk2++ruJrUAXIiu+CdurNyMsErQDDjf5G1epwnQ2iBTXyTx+zHsqynUlmyNH0ECVV4gZQJ/DTk5XiJpWwlUj4vwqrPDQQ9hndRK/gzFULavcx5DsMfvApKwzrNFCgiTDzhLSmfvlxd4Hf2peFZIKiSElKg350HaqlY9baWMIBnaWIK2/ySPQjfFHn9z6cFw1E2MsyXDnlhirCixvbqCtw2scsbhlmYhBHGUEWA87Znf/4xhAz2oVr8+dtmZud83YYbpWVGU9ouInzhpVx1Rl7+8ZY8MCCMnHOtJ+zNgmjqbkDbU/QRa+2gZ8XbFto+uBrFqVX+gEtIoq3z0P8947QDRyUOm2o7UviBWC5RcO6OtY6sPGmElSxVqhUar37g4NL9/rKZekpfUlU9kqIH4HDk72ABm5RZcfNkgw3svH39BQC5mNq8YRA06iIflLzViGhPfW0/rf3D8GB+npW7xoLVXMN3Sor29ywcDkddNSAXW89HRNOe3HpXILvs7rCG4FjfV9dA2DBywDgVxOoUmRcICNkIaJusixaAAStbe4YsorLH4L1+Y6Aa+JxbMBvT/Eyepc86s6YS20m5SPirNpVkBjUD+9PtAFNJnVYDuU5DHWePgzBPWVVL0EEPgHZ8cllTS3j80e9m4mzg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4129.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(136003)(376002)(366004)(346002)(451199021)(2616005)(38070700005)(83380400001)(66476007)(122000001)(66946007)(86362001)(38100700002)(41300700001)(5660300002)(36756003)(66556008)(66446008)(4326008)(64756008)(316002)(8936002)(8676002)(6916009)(91956017)(6512007)(6486002)(186003)(6506007)(76116006)(71200400001)(53546011)(26005)(33656002)(54906003)(478600001)(2906002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UFA0ZmYvK3grYWxWU1dhamNTRlV3RER0QitCbElJL09scmF0TGxRSEFhRXFN?=
 =?utf-8?B?cE4wUXRNV0I5cGtFNSt0ZERBKzdNaHVVTjNVeTVCSnMwdXhKcEN4K1FlUlM2?=
 =?utf-8?B?ZGQyMm5YSDkrWE8ydW91SXZQVG5yUjN1RFh3SWxPdUpMRmFqTkdkVmY1ZWxR?=
 =?utf-8?B?SnQzSVZFK0tjQXA5ZGNVbG0zOUlrYTRJejR2VG5UZlErOEZwVHAzL2RIdkFQ?=
 =?utf-8?B?K1dXV09zY1A4bU1xK3doL2VnL3hDQ1ZTOUdwMjBTNVBYbTFHNmlZUEVXNDY0?=
 =?utf-8?B?OFU1Mk5ZVFUwczY0ZnhWNGJTOGZZT1FoUUpnZHp5TXJMSjBuaWVkTEtXTy9U?=
 =?utf-8?B?a2NQNW82Nks2WXFTeHp4bW9SYndwamdJSmYrakl3N2ZLWk9hcWZaLy9WSTlW?=
 =?utf-8?B?dmR4TGIxTG5reFFmNkp5cExYS2F3QjFrVVBCUkJzeTVLVnp0WnVPSE5YVzkx?=
 =?utf-8?B?NFd2Z1BpczMzVUx2a01VekNXUkJVeHpTTXFmYlVlNUNRcW5pMFdzTi9acDdM?=
 =?utf-8?B?M1hhU0RHL1V6OUNjZkRicHdvbm5pdGJPTDR3NDQ3QXljckxqblpneDhxRURw?=
 =?utf-8?B?eGRGdElhSExRZ1I2S0duMmpNR0NzVDI1bHYzSHBBU1JlOEttTjBid3FRUkF4?=
 =?utf-8?B?cCt5WUJWOXgrWGZ0Vy9maFJqekZydEhEcndKZUxSa2w4THpPS3NZMk5wNHJM?=
 =?utf-8?B?TTRVOWwwQml1WlpicWhaaWpnU053akdIY2tuM2hoUVAyWHY5eUJRN3Y4SW0v?=
 =?utf-8?B?Yk1RdWdrTDgzWklMTzVwZS9wYkRYTjF3dFhBbjBNTzNmK1RVc2d1MEVMM0Rk?=
 =?utf-8?B?T2NxMDllUGpGRFgzMUQ2RG5RRDh3VE1HdDJadEl5OWNZYWc1aHRwYU14R1Jz?=
 =?utf-8?B?ZU55NS82eEw1V2VscFhpTTcxYlByUVR4bktpU3pQOW5rR2ZheXUyeCtGR29R?=
 =?utf-8?B?aUsvdGJPZTBsNVZjcU5STWoyclBBbTFzaFdyYUE2TFgyUUlTYkU5Mk96T2Y1?=
 =?utf-8?B?dGo5THp2OFhIbkJ1VGZiZktFLzFqYWY1b3EwZWxTNGovVnFZYUlEYW9pOVR0?=
 =?utf-8?B?UWxxdXFRVWkrakVRSlA1YUo0Tm5JRmc5b2FGYzFGWExjdm8vcHBGY0ZEN3RT?=
 =?utf-8?B?QTB3YTYxRS9JRjNXWVJhYWlPWDNmb1NqanJ4bWc0VmFaek1PVEhWU1dhNkdw?=
 =?utf-8?B?cnVsaTRnSUpJRWFzbkRTRFZKOGtVS0VpS2xwNmpiN0RPZlR1Y3Y4aVpsempx?=
 =?utf-8?B?VG45MWRrUVpkL1BNakIxR2dBYjFDUGp4alZxRzZucDJJQWxyR3VwcEFNcmNY?=
 =?utf-8?B?QnVMNUp3SnBXT0M4b0puVnZEV3JySFp4WWd1SGNwRXZhVndBS3FIaVl3WUxY?=
 =?utf-8?B?NGtGRWVuOGx2TkNtalRMM3U3cU4zQ0NwS0xiV2dKRlNpbHRvVGhnWlhjaWtI?=
 =?utf-8?B?ZXkxTXVkc1hBenpYa1IvdWhkUk0vRVNacGRoWWJkLzZoNEcxKzZZL3dwVXhX?=
 =?utf-8?B?aS8wb01jcllreS9pQ0RPSWNKUUR2MDIzeTZuUEFtWEt1NGxBNCtmeEY3UG9o?=
 =?utf-8?B?SVZUdVFXcCs2bmRBRVVEL3pXUVIxTmJDVWhuaTAzS3EzVGR3dzFTMmdBVE04?=
 =?utf-8?B?ZFF5UTEzd3NIb3lBZFFERnhNUEVLUlc3RlphREtyTS9IZVdjYzNPaDBBUUNx?=
 =?utf-8?B?ZUQySE9RT0owb3daYmZ5Sk9DdEkyRmdEVzlZajd1VDdTYjJyam4rNjNwa3BE?=
 =?utf-8?B?UmR1QmVHSzFQbXNoTXJXZjg1MkpEbVNMZHh3UVVOUEMwN0w5NDhvVVcrZ1Bs?=
 =?utf-8?B?d1ZUUHc3ZHYzWnhNOUdsUi9LTm9xd1NoN2RGRzhqZGxzaENJYW02Z2Q5czJE?=
 =?utf-8?B?cDAweHZGMnlCUStNSVZEelUxQ1htM1ZoZ3M3S2xRcHpmaGV5NXdremRDWURP?=
 =?utf-8?B?SDBjMWlEeElOeGJqMi9OVzBHTUR6SUZRZ0J4L01FNmVzamd1NjBSNDh1dGJw?=
 =?utf-8?B?bzlmSDh2SkRCSSt5bjdKWGxDU2dua2c3eStGeTc0TDNEMnhzS0VVMHdnQ2g5?=
 =?utf-8?B?bmNWUmVNYTZyTmlOcUxiUjNBYkQ3c1Y3YURXdEVXZTd0TVU1RXVtMkx4NGVX?=
 =?utf-8?B?ODNNWHV5b3h4TGorVFZ5SGJ4SzZyS2dqYlJnUDhHM0tjTWFZc3BYbjBseCt1?=
 =?utf-8?B?TGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5A083097FB4B9C498EED6F108752A40E@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 15YBHWsMaEjVuyxwqSOzFDfe4B3cCwim/g1H2ubko3tAsZzO5W9pYc4lUINleR5hIXyvUwT9eq4hZYIl56rNEbD7Lu7EZNxVxHt707AYjypk8OUKc5I1Dwyc83NQqN7iLQkiOgA8ZH7lsBvuEGyA7HRj4wHMokVSK4yihE0pDrirx1r+AIVrb8sXrfBXbzyY4dB8qzIgw0aF/Np70Om3Cqn2aRK8gzrxeATuAZZvk/gk1x0jH85CoI4Tk2D7syWWLBcFdqb5S1P1n/Y7oUCOwPADldXPr1WqXN+F10bNnUDOnrLbJknc7a/09Eiratfm2HVd1/x0Y3tu3a8sM9s8V1ULy61Vmz4YyqFT7KFnElBlUyrrM+IyWuZPzbGuy9doibFmuwIp+gBKC8kAdrHuhoHrCc3gvAI+nNWGPvAH2jtH7zEBl6jLKlE4HcZsEqwoLZ2NnvQ3SeMfes3eLXJuK7NeiaBkS02y282JQ17qarJnZC9V+rPlZAqM3LMLMHqljcv7gYH4740A4bxA59SPchTeliV5kZbIa02Ll0LmsvxFdZjqWUBP5FpQfsHj4k/Rv6csrKgpl9GNdFYRiqd4TXDy4c6VCfa24OzfWhCTgKN3OWo0ZmwJOPymPK+H9rimJtSOnSsf1MUS6rsG0MCXxxPNaAEOIByPJ+B8LOMblAsgVNKyGT/oBnM9gK8qjUJyWkMpgytTtt44sbOb9oqy4sLzfmOhA3L5k6I5RazaXvWbSCZeH0PEF6C5N5ixMlyhZ9vg2UmN2QvXv5gZy1Fr/q0kGNqEUgdDDXFuQsOxjusJdFwRvoP/iXL17SN3KLGtKgsuAPwHfUyb8k8B3kQFD6bGjOHe+CDgLI2qCAe4+q90DPSN7zGLHj0uFdkgB+jw
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4129.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 145b06dc-5cf9-4520-3876-08db8fc981a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2023 00:19:42.8952
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jufQh7Mf2y5DJmNMkWiw9SgMRSpRb4WukVock1eGmIU24DYfVzVfa3S1NYn9eV1oUhMO4/fR/Dor38lXwQ84HclUDKqXw5xgEObv9m04ODk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7747
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_10,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 adultscore=0 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307290001
X-Proofpoint-ORIG-GUID: juGPgRlB3OhgKgbbXSjttZ34EymjpR9-
X-Proofpoint-GUID: juGPgRlB3OhgKgbbXSjttZ34EymjpR9-
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

DQoNCj4gT24gSnVsIDI4LCAyMDIzLCBhdCA0OjAwIFBNLCBTaHVhaCBLaGFuIDxza2hhbkBsaW51
eGZvdW5kYXRpb24ub3JnPiB3cm90ZToNCj4gDQo+IE9uIDcvMjgvMjMgMTY6NDAsIEFuamFsaSBL
dWxrYXJuaSB3cm90ZToNCj4+PiBPbiBKdWwgMjgsIDIwMjMsIGF0IDM6MjUgUE0sIFNodWFoIEto
YW4gPHNraGFuQGxpbnV4Zm91bmRhdGlvbi5vcmc+IHdyb3RlOg0KPj4+IA0KPj4+IE9uIDcvMjgv
MjMgMTU6NTksIEFuamFsaSBLdWxrYXJuaSB3cm90ZToNCj4+Pj4+IE9uIEp1bCAyOCwgMjAyMywg
YXQgMjo0MSBQTSwgU2h1YWggS2hhbiA8c2toYW5AbGludXhmb3VuZGF0aW9uLm9yZz4gd3JvdGU6
DQo+Pj4+PiANCj4+Pj4+IE9uIDcvMjgvMjMgMTU6MjEsIEFuamFsaSBLdWxrYXJuaSB3cm90ZToN
Cj4+Pj4+Pj4gT24gSnVsIDI4LCAyMDIzLCBhdCAxMjo0NCBQTSwgU2h1YWggS2hhbiA8c2toYW5A
bGludXhmb3VuZGF0aW9uLm9yZz4gd3JvdGU6DQo+Pj4+Pj4+IA0KPj4+Pj4+PiBPbiA3LzI4LzIz
IDEzOjA2LCBTaHVhaCBLaGFuIHdyb3RlOg0KPj4+Pj4+Pj4gT24gNy8yOC8yMyAxMjoxMCwgQW5q
YWxpIEt1bGthcm5pIHdyb3RlOg0KPj4+Pj4+Pj4+IA0KPj4+Pj4+Pj4+IA0KPj4+Pj4+Pj4+PiBP
biBKdWwgMjgsIDIwMjMsIGF0IDEwOjI5IEFNLCBTaHVhaCBLaGFuIDxza2hhbkBsaW51eGZvdW5k
YXRpb24ub3JnPiB3cm90ZToNCj4+Pj4+Pj4+Pj4gDQo+Pj4+Pj4+Pj4+IHByb2NfZmlsdGVyIHRl
c3QgcmVxdWlyZXMgcm9vdCBwcml2aWxlZ2VzLiBBZGQgcm9vdCBwcml2aWxlZ2UgY2hlY2sNCj4+
Pj4+Pj4+Pj4gYW5kIHNraXAgdGhlIHRlc3QuIEFsc28gZml4IGFyZ3VtZW50IHBhcnNpbmcgcGF0
aHMgdG8gc2tpcCBpbiB0aGVpcg0KPj4+Pj4+Pj4+PiBlcnJvciBsZWdzLg0KPj4+Pj4+Pj4+PiAN
Cj4+Pj4+Pj4+Pj4gU2lnbmVkLW9mZi1ieTogU2h1YWggS2hhbiA8c2toYW5AbGludXhmb3VuZGF0
aW9uLm9yZz4NCj4+Pj4+Pj4+Pj4gLS0tDQo+Pj4+Pj4+Pj4+IHRvb2xzL3Rlc3Rpbmcvc2VsZnRl
c3RzL2Nvbm5lY3Rvci9wcm9jX2ZpbHRlci5jIHwgOSArKysrKysrLS0NCj4+Pj4+Pj4+Pj4gMSBm
aWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4+Pj4+Pj4+Pj4g
DQo+Pj4+Pj4+Pj4+IGRpZmYgLS1naXQgYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9jb25uZWN0
b3IvcHJvY19maWx0ZXIuYyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2Nvbm5lY3Rvci9wcm9j
X2ZpbHRlci5jDQo+Pj4+Pj4+Pj4+IGluZGV4IDRmZThjNjc2M2ZkOC4uN2IyMDgxYjk4ZTVjIDEw
MDY0NA0KPj4+Pj4+Pj4+PiAtLS0gYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9jb25uZWN0b3Iv
cHJvY19maWx0ZXIuYw0KPj4+Pj4+Pj4+PiArKysgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9j
b25uZWN0b3IvcHJvY19maWx0ZXIuYw0KPj4+Pj4+Pj4+PiBAQCAtMjQ4LDcgKzI0OCw3IEBAIGlu
dCBtYWluKGludCBhcmdjLCBjaGFyICphcmd2W10pDQo+Pj4+Pj4+Pj4+IA0KPj4+Pj4+Pj4+PiBp
ZiAoYXJnYyA+IDIpIHsNCj4+Pj4+Pj4+Pj4gcHJpbnRmKCJFeHBlY3RlZCAwKGFzc3VtZSBuby1m
aWx0ZXIpIG9yIDEgYXJndW1lbnQoLWYpXG4iKTsNCj4+Pj4+Pj4+Pj4gLSBleGl0KDEpOw0KPj4+
Pj4+Pj4+PiArIGV4aXQoS1NGVF9TS0lQKTsNCj4+Pj4+Pj4+Pj4gfQ0KPj4+Pj4+Pj4+PiANCj4+
Pj4+Pj4+Pj4gaWYgKGFyZ2MgPT0gMikgew0KPj4+Pj4+Pj4+PiBAQCAtMjU2LDEwICsyNTYsMTUg
QEAgaW50IG1haW4oaW50IGFyZ2MsIGNoYXIgKmFyZ3ZbXSkNCj4+Pj4+Pj4+Pj4gZmlsdGVyID0g
MTsNCj4+Pj4+Pj4+Pj4gfSBlbHNlIHsNCj4+Pj4+Pj4+Pj4gcHJpbnRmKCJWYWxpZCBvcHRpb24g
OiAtZiAoZm9yIGZpbHRlciBmZWF0dXJlKVxuIik7DQo+Pj4+Pj4+Pj4+IC0gZXhpdCgxKTsNCj4+
Pj4+Pj4+Pj4gKyBleGl0KEtTRlRfU0tJUCk7DQo+Pj4+Pj4+Pj4+IH0NCj4+Pj4+Pj4+Pj4gfQ0K
Pj4+Pj4+Pj4+PiANCj4+Pj4+Pj4+Pj4gKyBpZiAoZ2V0ZXVpZCgpKSB7DQo+Pj4+Pj4+Pj4+ICsg
cHJpbnRmKCJDb25uZWN0b3IgdGVzdCByZXF1aXJlcyByb290IHByaXZpbGVnZXMuXG4iKTsNCj4+
Pj4+Pj4+Pj4gKyBleGl0KEtTRlRfU0tJUCk7DQo+Pj4+Pj4+Pj4+ICsgfQ0KPj4+Pj4+Pj4+PiAr
DQo+Pj4+Pj4+Pj4gDQo+Pj4+Pj4+Pj4gSSBhbSBub3Qgc3VyZSB3aHkgeW91IGhhdmUgYWRkZWQg
dGhpcyBjaGVjaz8gcHJvY19maWx0ZXIgZG9lcyBub3QgbmVlZCByb290IHByaXZpbGVnZSB0byBy
dW4uDQo+Pj4+Pj4+Pj4gDQo+Pj4+Pj4+PiBJdCBmYWlsZWQgZm9yIG1lIHdoZW4gSSByYW4gaXQg
c2F5aW5nIGl0IHJlcXVpcmVzIHJvb3QgcHJpdmlsZWdlcy4NCj4+Pj4+Pj4+IEkgaGFkIHRvIHJ1
biBpdCBhcyByb290Lg0KPj4+Pj4+PiANCj4+Pj4+Pj4gVGhlIGZvbGxvd2luZyBpcyB3aGF0IEkg
c2VlIHdoZW4gSSBydW4gdGhlIHRlc3QgYXMgbm9uLXJvb3QNCj4+Pj4+Pj4gdXNlcjoNCj4+Pj4+
Pj4gDQo+Pj4+Pj4+IGJpbmQgZmFpbGVkOiBPcGVyYXRpb24gbm90IHBlcm1pdHRlZA0KPj4+Pj4+
PiANCj4+Pj4+PiBZZXMsIHRoYXTigJlzIGV4cGVjdGVkIG9uIGEga2VybmVsIHdoaWNoIGRvZXMg
bm90IGhhdmUgdGhlIGtlcm5lbCBwYXRjaGVzIHN1Ym1pdHRlZCB3aXRoIHRoaXMgc2VsZnRlc3Qg
aW5zdGFsbGVkIG9uIGl0Lg0KPj4+Pj4+IFNvIHRoaXMgY2hlY2sgZm9yIHJvb3QgbmVlZHMgdG8g
YmUgcmVtb3ZlZC4NCj4+Pj4+IA0KPj4+Pj4gSSB3aWxsIHNlbmQgdjIgZm9yIHRoaXMgcGF0Y2gg
d2l0aG91dCByb290IGNoZWNrLiBJIHNob3VsZCBoYXZlDQo+Pj4+PiBzcGxpdCB0aGUgYXJndW1l
bnQgZXJyb3IgcGF0aHMgYW5kIHJvb3QgY2hlY2sgYW55d2F5Lg0KPj4+Pj4gDQo+Pj4+PiBIb3dl
dmVyLCB3aGF0IGlzIHN0cmFuZ2UgaXMgaWYgdGhlIHRlc3QgcnVuIGJ5IHJvb3QsIGJpbmQoKSBk
b2Vzbid0IGZhaWwuDQo+Pj4+PiBUaGlzIGRvZXNuJ3QgbWFrZSBzZW5zZSB0byBtZSBiYXNlZCBv
biB3aGF0IHlvdSBzYWlkIGFib3V0IGJpbmQoKSBmYWlscw0KPj4+Pj4gaWYga2VybmVsIGRvZXNu
J3Qgc3VwcG9ydCB0aGUgbmV3IGZlYXR1cmUuDQo+Pj4+PiANCj4+Pj4gSSBkaWRu4oCZdCBzYXkg
dGhhdCAtIHBhcnQgb2YgdGhlIGNoYW5nZXMgaW50cm9kdWNlZCBieSB0aGUgcGF0Y2hlcyBpcyB0
byByZW1vdmUgdGhlIHJvb3QgY2hlY2sgYW5kIGFkZCBzb21lIGZlYXR1cmVzIG9uIHRvcCBvZiBl
eGlzdGluZyBjb2RlLg0KPj4+IA0KPj4+IE9rYXkuIFNvIHdoYXQgc2hvdWxkIGhhcHBlbiBpZiBh
IHJvb3QgdXNlciBydW5zIHRoaXMgdGVzdCBvbiBhIGtlcm5lbA0KPj4+IHRoYXQgZG9lc24ndCBo
YXZlIHRoZSBrZXJuZWwgcGF0Y2hlcyBzdWJtaXR0ZWQgd2l0aCB0aGlzIHNlbGZ0ZXN0DQo+Pj4g
aW5zdGFsbGVkIG9uIGl0Pw0KPj4+IA0KPj4gSXQgd2lsbCBkZWZhdWx0IHRvIHRoZSBiZWhhdmlv
ciBwcmV2aW91cyB0byBteSBjaGFuZ2VzIC0gdGhhdCBpcyBpdCB3aWxsIHJlcG9ydCBhbGwgZXZl
bnRzIGFzIG9wcG9zZWQgdG8gYSBzdWJzZXQgb2YgZXZlbnRzICh3aGljaCBpcyB0aGUgbmV3IGZl
YXR1cmUgYWRkZWQgYnkgbXkgY2hhbmdlKQ0KPiANCj4gT2theS4gU29ycnkgSSBhbSB1bmFibGUg
dG8gZm9sbG93IHRoaXMgZXhwbGFuYXRpb24uIFRoaXMgdGVzdCBoYXMganVzdA0KPiBiZWVuIGFk
ZGVkIGluIGNvbW1pdCA3M2EyOTUzMWY0NWZlZDY0MjMxNDQwNTdkN2E4NDRhYWU0NmRhZDlkDQoN
ClllcywgdGhlIHRlc3QgaGFzIGJlZW4gYWRkZWQganVzdCBub3csIGJ1dCBpdCBhbHNvIHRlc3Rz
IGtlcm5lbHMgcHJldmlvdXMgdG8gdGhlIG5ldyBmZWF0dXJlIGFkZGl0aW9uLiBTbyBpdCBpcyBh
ZGRpbmcgYSBzZWxmdGVzdCB0byBrZXJuZWxzIHByZXZpb3VzIHRvIHRoaXMgY29tbWl0LiANClRo
YXQgaXMsIHRoZSBjb25uZWN0b3IgbW9kdWxlIGluIGtlcm5lbCAoYmVmb3JlIG15IGNoYW5nZXMp
IHdhcyBzZW5kaW5nIHRvIGEgbGlzdGVuZXIgdXNlciBwcm9jZXNzIG1lc3NhZ2VzIGZvciBhbGwg
cHJvY2VzcyBldmVudHMgLSBmb3JrLCBleGl0LCBleGVjIGV0Yy4gVGhpcyB3YXMgb25seSBiZWlu
ZyBkb25lIGlmIHRoZSB1c2VyIHByb2Nlc3Mgd2FzIHJ1biBhcyByb290Lg0KV2l0aCBteSBjaGFu
Z2VzLCB3ZSBhZGQgZmlsdGVyaW5nIGJhc2VkIG9uIGFuIG9wdGlvbiBhZGRlZCBieSB1c2VyLCB3
aGljaCBmaWx0ZXJzIGJhc2VkIG9uIGlucHV0IGFuZCBnaXZlcyBiYWNrIHRvIHRoZSB1c2VyIG9u
bHkgZm9yaywgb3Igb25seSBleGl0LCBvciBhIGNvbWJpbmF0aW9uIG9mIHRob3NlLiBUaGlzIGlz
IGEgbmV3IGZlYXR1cmUgYWRkZWQuIEluIGFkZGl0aW9uIHRvIHRoaXMgZmlsdGVyaW5nLCB3ZSBo
YXZlIGFsc28gbWFkZSB0aGUgY2hhbmdlIHRvIGFsbG93IHVzZXIgcHJvY2VzcyB0byBiZSBub24t
cm9vdCB3aGVuIHJlY2VpdmluZyB0aGVzZSBtZXNzYWdlcy4NCg0KPiANCj4gQ2FuIHlvdSBwbGVh
c2UgbG9vayBhdCB0aGUgdXNhZ2UgZm9yIHRoaXMgdGVzdDoNCj4gDQo+IC0gV2hhdCBzaG91bGQg
aGFwcGVuIHdoZW4ga2VybmVsIHdpdGhvdXQgZmlsdGVyaW5nIGlzIHJ1biBhcw0KPiByb290IG9y
IG5vbi1yb290DQoNCkJ5IGtlcm5lbCB3aXRob3V0IGZpbHRlcmluZyB5b3UgbWVhbiBhIGtlcm5l
bCB3aXRob3V0IG15IHBhdGNoZXM/IEluIHRoYXQgY2FzZSwgaXQgc2hvdWxkIHJ1biBvbmx5IGFz
IHJvb3QgLSBub24tcm9vdCBzaG91bGQgZmFpbC4gSW4gdGhpcyBjYXNlLCBpdCBmYWxscyBiYWNr
IHRvIGRlZmF1bHQgYmVoYXZpb3IgYmVmb3JlIG15IGNoYW5nZSwgd2hlcmUgbGlzdGVuZXIgdXNl
ciBwcm9jZXNzIGdldHMgYWxsIG1lc3NhZ2VzIHJlbGF0ZWQgdG8gcHJvY2VzcyBldmVudHMuIEkg
aGF2ZSBub3QgdGVzdGVkIHRoaXMgYSBsb3QsIEkgYW0gd29ya2luZyBvbiB0ZXN0aW5nIHRoaXMg
b24gYSBrZXJuZWwgd2l0aG91dCBteSBjaGFuZ2VzLg0KDQo+IC0gV2hhdCBzaG91bGQgaGFwcGVu
IHdoZW4ga2VybmVsIHdpdGggZmlsdGVyaW5nIGlzIHJ1biBhcw0KPiByb290IG9yIG5vbi1yb290
DQo+IA0KDQpJdCBzaG91bGQgYWxsb3cgbm9uLXJvb3QgdXNlciBhcyB3ZWxsIGFzIHJvb3QgdXNl
ciB0byBsaXN0ZW4gdG8gZXZlbnRzIGJhc2VkIG9uIHdoYXQgdGhleSB3YW50IHRvIGxpc3RlbiB0
by4NCg0KPiBUaGVyZSBzZWVtcyB0byBiZSBkaWZmZXJlbmNlIGluIGJlaGF2aW9yIG9mIHRoaXMg
dGVzdCBkZXBlbmRpbmcNCj4gb24gdXNlciBwcml2aWxlZ2VzLiBUaGlzIHNob3VsZCByZWZsZWN0
IGluIHRoZSBtZXNzYWdlIHRoZSB1c2VyDQo+IHNlZXMuDQoNClRoYXTigJlzIGJlY2F1c2UgSSBh
bSBhbGxvd2luZyB0aGlzIHRlc3QgdG8gd29yayB3aXRoIG5ldyBjaGFuZ2VzIGFzIHdlbGwgYXMg
YWxsb3cgb2xkIG1ldGhvZCB0byB3b3JrLiBPbGQgbWV0aG9kIGlzIGludm9rZWQgd2l0aG91dCBh
bnkgYXJndW1lbnRzIHN1cHBsaWVkIHRvIHRoaXMgcHJvZ3JhbS4gLWYgb3B0aW9uIGludm9rZXMg
bmV3IGZpbHRlcmluZy4NCg0KPiANCj4gVGhpcyBtZXNzYWdlICJiaW5kIGZhaWxlZDogT3BlcmF0
aW9uIG5vdCBwZXJtaXR0ZWQiIGRvZXNuJ3QgdGVsbA0KPiB1c2VyIGFueXRoaW5nIC0gYWRkIGEg
YmV0dGVyIG1lc3NhZ2UuIEFsc28gdGhpcyBuZWVkcyB0byBiZSBhIHNraXANCj4gYW5kIG5vdCBm
YWlsLg0KDQpXaWxsIGRvLg0KDQo+IA0KPiBJIGp1c3Qgc2VudCB2MiB3aXRob3V0IHRoZSByb290
IGNoZWNrLg0KPiANCj4gdGhhbmtzLA0KPiAtLSBTaHVhaA0KDQo=
