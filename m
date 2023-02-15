Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 065F26978D4
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Feb 2023 10:19:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbjBOJTE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Feb 2023 04:19:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbjBOJTD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Feb 2023 04:19:03 -0500
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 15 Feb 2023 01:19:02 PST
Received: from esa1.hc3370-68.iphmx.com (esa1.hc3370-68.iphmx.com [216.71.145.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D382712
        for <linux-kselftest@vger.kernel.org>; Wed, 15 Feb 2023 01:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1676452741;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2bGGoQrb0x5GeMxPsm4LpY5uTxiyZujMdoHCtHBJY8k=;
  b=cRU6jIU9AflxEgQJZ/sWU6DfGuJcRUSCOxsJBVbDgTsvNCf9/m64hEr5
   okFHS/wiWjGaTRCkKA4XKMABs1+KPxBJdW1hy9eaM3Buh/aseK9LAFsWE
   LwW8PLknifFLWqP7HLeySoVazH8Kp28aiv1CdyCxNxUWL3fRdjsjn7lvm
   s=;
X-IronPort-RemoteIP: 104.47.66.44
X-IronPort-MID: 97521476
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:aLcdv6/Rfz/+V0trHbsdDrUDtn6TJUtcMsCJ2f8bNWPcYEJGY0x3y
 TcZXGiPPvfbNGumeo1xPYjn9EsB7cCHnddrQFNuqns8E34SpcT7XtnIdU2Y0wF+jCHgZBk+s
 5hBMImowOQcFCK0SsKFa+C5xZVE/fjUAOG6UKicYXoZqTZMEE8JkQhkl/MynrlmiN24BxLlk
 d7pqojUNUTNNwRcawr40Ire7kIw1BjOkGlA5AdmP6kW5Aa2e0Q9V/rzG4ngdxMUfaEMdgKKb
 76r5K20+Grf4yAsBruN+losWhRXKlJ6FVHmZkt+A8BOsDAbzsAB+v9T2M4nQVVWk120c+VZk
 72hg3ASpTABZcUgkMxFO/VR/roX0aduoNcrKlDn2SCfItGvn9IBDJyCAWlvVbD09NqbDklg5
 6YYFxcmSiqehvOI+p+pbMpKmJUaeZyD0IM34hmMzBn/JNN/G9XmfP+P4tVVmjAtmspJAPDSI
 dIDbiZiZwjBZBsJPUoLDJU5n6GjgXyXnz9w8QrJ4/ZopTaNilAtuFTuGIO9ltiibMNZhEuH4
 EnB+Hz0GEoyP92D0zuVtHmrg4cjmAuqB99ITeHnqJaGhnWDwXUxMSc4DGKWrKCC0U6hWu9zN
 hEtr39GQa8asRbDosPGdxS9pXeesBcdSdsKO+I89R6Ax6CS5ByWbkAEVjdpes06s9VwTjsvv
 neFls3kQzxmtqaYT1qc8KuZqXW5Pi19BWMLeyJCTQID+NTliIUyiA/fCNdlDKOxyNbyHFnYw
 DGQrSw6wa4TkNIG0qKl1VTGhS+84JnPUgMxoA7QWwqN8gx9dKahZoq19ULc6/dQaoqUJnGZs
 WQJgdq27eYAF5iBmSWBBuIXE9mB7eyKPSfHnXZgGpAg83Km/HvLVYpIyDh6JUpvYoAIdFfBe
 0/OsAN555JJOnauK6htbOqZDsUswq/IFtn/UP3QKN1UbfBZcBKb+wltaFSW0mSrl1Ij+Ykva
 cmzcsu2C3seT6N9w1KeQ+YbzK9uxTszwW3PSIvn5wqo3KDYZ3OPT7oBdlyUYYgR6KKCvRWQ8
 NtFMcaO4wtQXfe4YSTN94MXa1cQIhAG6YversVWcquGPVBgEWR4UfvJm+t9J8pigrhfkfrO8
 jelQEhExVHjhHrBbwKXdnRkb7CpVpF6xZ4mARER0Z+T8yBLSe6SAG03KPPboZFPGDRf8MNJ
IronPort-HdrOrdr: A9a23:4b1u/69te/E2n5T7mH5uk+DPI+orL9Y04lQ7vn2ZKCYlEfBw8v
 rE9sjzuiWE6gr5J0tQ/OxoVJPsfZq+z/5ICOsqU4tKNTOO0FdASrsP0WKI+Vzd8kPFmdK13J
 0QF5RDNA==
X-IronPort-AV: E=Sophos;i="5.97,299,1669093200"; 
   d="scan'208";a="97521476"
Received: from mail-mw2nam12lp2044.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.44])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Feb 2023 04:17:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WovwaRwiSK9Ka1vqwmAc7GfluqAZ+b3npA2iwk4d49mUTCCnmzweXFZ0YjVnmPFl2VcMebHNIv7a7ceutUt3ej4eIj+K9Se4Mejd7NUYS5KMK+CntZErjrYvSnCq+1Ay9/mvAHXkwNHppb3sMsMs77C+E6RMzFVCtoUUgBTKsORp3ecshDRYBo6MszPrAM+RsdtGj0gxmgZ1gXqexD5ufJjgqt/4+URe63xnakYT+1vdJIXu2Kza86Tdy9EDfU6lX6xuGQJUOzTTTE2axULfIMwyZ5yTsLLP7kwiMjw2YwANVBB5Sa+9ycX1T7vp/KiBNha8cMdbYAnFTn8opn+UdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oE/iF6z2lWamzO64tGiIpHCSv2Ve21dh4s2Ah0vRLxo=;
 b=LOnLtqb/LyUWfXgS70Fw47tkqqy6OqfuGK/c4yAzKgTTqoUVdN8By+k4WIY81iEx8sJz1vCBqAh7ndzS5+YPPcURZ/n9IRahFDn4g5nLaE6WfPch0323IofET9VsSOEOKhNqwsnignqt/9NiRb8olfUcVtlsyi77mxzXZjCGAj9Fq+h3XG/82gL4XjSSaeZvYD37HsJzBLP7/US0/ZV3Zc/vGoKlYjDEFCb7nmPjeO4c/r4DCQwV/4XXRh/+c/gbpnZOosG60Z9NhgEdPWcJp2d1StLFJMwT8qoI6SkjugGwoAoDxNDn56jarodtOS7p5EBtnGtJ2exD9Ii8hclGLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oE/iF6z2lWamzO64tGiIpHCSv2Ve21dh4s2Ah0vRLxo=;
 b=f6qmDRn+wIpkETvcGqHeURhjALB5W8KTGjoWozi1nZF/4w6OVWwZ7RUE8po4FrE/xdX0rDt4sApA/HpM4zaBTxGrzje1Wv0wzoZcVya+AsNekBBZ5kVhCHwVUc61VAXeE9WDDPbFw/Ta0M0CTV5uBGvKdsuuamfkd/+0wrjK5J8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from BYAPR03MB3623.namprd03.prod.outlook.com (2603:10b6:a02:aa::12)
 by MW4PR03MB6617.namprd03.prod.outlook.com (2603:10b6:303:128::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.32; Wed, 15 Feb
 2023 09:17:30 +0000
Received: from BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::8299:f95f:934b:29e8]) by BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::8299:f95f:934b:29e8%7]) with mapi id 15.20.6086.024; Wed, 15 Feb 2023
 09:17:30 +0000
Message-ID: <0b57d2ab-14e0-14a0-adf3-3186fd2f5282@citrix.com>
Date:   Wed, 15 Feb 2023 09:17:23 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
From:   Andrew Cooper <Andrew.Cooper3@citrix.com>
Subject: Re: [RFC PATCH v1 1/2] selftests/x86: sysret_rip: Handle syscall in a
 FRED system
Content-Language: en-GB
To:     Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Brian Gerst <brgerst@gmail.com>,
        Borislav Petkov <bp@alien8.de>, Shuah Khan <shuah@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        x86 Mailing List <x86@kernel.org>,
        Linux Kselftest Mailing List 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <SA1PR11MB673498933098295BFC7C2900A8CB9@SA1PR11MB6734.namprd11.prod.outlook.com>
 <b6e36a5c-6f5e-eda6-54ad-a0c20eb00402@intel.com>
 <25b96960-a07e-a952-5c23-786b55054126@zytor.com>
 <fb1cab9f-a373-38e6-92e6-456332010653@gnuweeb.org>
 <F554C5FE-5074-410A-B0B5-EFE983D57946@zytor.com>
 <Y88bhrDoPw5tOyKu@biznet-home.integral.gnuweeb.org>
 <509443c8-e0fd-935f-63d8-7264f5dd3c05@zytor.com>
 <20230124002625.581323-1-ammarfaizi2@gnuweeb.org>
 <20230124002625.581323-2-ammarfaizi2@gnuweeb.org>
 <8f5c24df-514d-5d89-f58f-ec8c3eb1e049@zytor.com>
 <Y9LdwVX9BaZA7zmA@biznet-home.integral.gnuweeb.org>
In-Reply-To: <Y9LdwVX9BaZA7zmA@biznet-home.integral.gnuweeb.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0186.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a4::11) To BYAPR03MB3623.namprd03.prod.outlook.com
 (2603:10b6:a02:aa::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB3623:EE_|MW4PR03MB6617:EE_
X-MS-Office365-Filtering-Correlation-Id: 413232fd-ca71-4aca-303a-08db0f357693
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LNrdwwsdCy4JJVIggTxqjapZwkyr9BOTh2toi/H4LdVjZyEPIWg9oPoXmHwy0Sj9koakgdF6RAhMzgKSHD0m+dRlE2Y5iCe/lh6nBm2WuwNItDn5eWDTZQl7d5amYu3ZuG8wyXc9szgJXZ+Ik4/TYGvYnCLsaqfMVL12yF1wW2CD53MBuGqWFR+xTbNX1mX+2c9HmeigPKfrseusVCiCPnph63zWJVxc6cJzc7hfRfD5GgzfMCZyLmCx73kJI6r+seX2Tsz75SarzwtobeZdhGCUVfVmlv2/zW2VVK67yLhyS3Rg0Ppp9wNCieFNwr239+jYVd/Ph3LAgaUf51GDJawpITRSMBhTce8PKefXJ+lHgPs7jk086LeEhP5wAuFRO+slMsw0Z2GnKM6ThCeGm3XPKq94gOc6MPesC7hLlFrSj4+iAPSl5AEd1StPE4QRSOYZ/oKk/rsFCLPvBLP9jpYZ8LJm8ehZD2+fRu44suEvwFrVXAirHsJDZkQbWaH2h8jKJBgIkEx+N5UKuDbZ7PfdFZiMGR2uUHZAuBPNzj5qpNBAaYJSNQ0WY6ny5I2x3n7xJQJ7aCwGcYBwdAwy2vJQxX47QAimoog7q1uEJZMNbbZeiNVhBuLnTpwb4YYhfV8zaaP/lf89kdn/+j9IwAjqTsJn64gKUelZZa4zijKQ/Q+MPpuH6w0r3yy5e0+9A3STHlWjj9uLqYf9awV5PuMTj3uA1i10rFsvOz9Y6Vs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3623.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(39860400002)(396003)(346002)(376002)(366004)(451199018)(7416002)(186003)(4744005)(31686004)(6512007)(6506007)(5660300002)(53546011)(26005)(2906002)(6666004)(8936002)(36756003)(2616005)(82960400001)(38100700002)(316002)(8676002)(31696002)(66476007)(4326008)(6486002)(66556008)(478600001)(41300700001)(110136005)(83380400001)(966005)(66946007)(54906003)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Wjk0M2QrQWFDczAzYXZXQm1TUmZTRmY5cjFVczZmUlNFUmU5SGJ3bkxPbm9n?=
 =?utf-8?B?Nk8vdXVKMXlWZGpEYUFkTXhDb1VZM1ZvQUx1R0JpZkFGeHFRNDlIT1plNC9V?=
 =?utf-8?B?T3Rha2xFamhkZFczQ3BXRUVWbjkwUWtUUFpySlFiUzRGOWVSdmdSZFlVUzk0?=
 =?utf-8?B?eVAvbGIvMHJIc0IvWHNRM3hPdTRnZ0xQeG9NQkErbFl4bVMwLzd1aDRDSlZX?=
 =?utf-8?B?R3V3cWRwS3BOM3lYSkl1SnhRdFk2YnMrVTM0eUFWTDBybGxKOGdIY3cyWVFJ?=
 =?utf-8?B?aTZKNnZEdldpWmV6Z1gvcUgydlV4bTN5ZFBpU2FVa2c4NXMwNk9odWRRQ0NT?=
 =?utf-8?B?anRQbERsNzJoYjR0UUF5MC93MXg3bTRsYUZwSTlWR2wvbk43ckZOVzAxbEFj?=
 =?utf-8?B?MG8xdnEvQTl6VG1Dd1czZ0JueThQTnovQWduakp2NDdDNk5Hbk1hM1h1OVJV?=
 =?utf-8?B?TDk2QzlCQStNQjd0dGNSemdUb3V1RmNKRjZGMWpBM1pOSDNnUUxnQUt4bllG?=
 =?utf-8?B?UFJ6VmVySXBaajIvREhhaTU5Y2xsV2w0VEdDZ0Z5MGJaNm94UW5ZUDRRUUpm?=
 =?utf-8?B?czR2WTRVb1BTbGpvV0tjZEtuVTZmU3RSMFhvYjFrOXlVdTMzY1FyWlFQMkVC?=
 =?utf-8?B?TE5DYUo3NDBSNk1KZERiKzVTL2krV2lmWC8xV1FJZ2QrcjJMZDk3eXJZRWtq?=
 =?utf-8?B?L1FBVWIyQkxicnFsUWFGcjlkckczT2cxQWtxbks4ZjhKS3BhUy9rTGxEWGIy?=
 =?utf-8?B?R1cyc0U4cTFXcDc5eHdSeHY1d3Z4SFFaa0RIVWZUeWVmanpjRTRaUjY3UWQ5?=
 =?utf-8?B?cU1iY0lQaDk5VVBvbHhrdE0rbXMzdDNlTWJ5dms4eTFqQ1hwNWxLT3M1VTNP?=
 =?utf-8?B?ZHdFQUhWcGVhMmFZSEJKUVNpSExNNGoyMmZmUTMzKzhQZlRtRDVDbXBjZVFG?=
 =?utf-8?B?WWM1ZVlBOXEyVmh3QWErL3Exa0JqQWRHWE4xZ1dHQm0xZG41M0U2R0dKUDlR?=
 =?utf-8?B?b29rWEc0MVg5Q1FoMzc1OG81T05uS0pQbW82dHM3T3o3NnRjRjg1KyticWRT?=
 =?utf-8?B?RjdObERuYmZGdW5NS2dSQUViZnBlTlppNFJuSElUUC9BZ2kzcUVSdTJzS2tG?=
 =?utf-8?B?YXZnTEFzSjAvdmg5SHdlZFRNU2FBRHVmTS9PZTNXNng5dFdPc1N4WE91aHRm?=
 =?utf-8?B?SHdEVHBIODloY3NKRzBZUDZKUTZkMndzSFd0V3p6U1RXU0l3b29nZmkzMWVH?=
 =?utf-8?B?a0RJMlVBRWk1c0xsd1JXbysxSXArNitRZ2VNOUMxRnp1K0kza3QyU24yOG50?=
 =?utf-8?B?dE1DaVoxRGJlK3A0ZjZsbStlWUpVOENCb2h4bTMvRW0wYmNYVDBPS2dob0Ns?=
 =?utf-8?B?aVdwTy91S2EwR2dmdDMydGJmelVNRHJIR084RzRFYm1HczJYSUppVHNiUGFI?=
 =?utf-8?B?NDI4VTMrbDBJSndQMXdpSWRKYmoxSmJ4YXJHd0NhcVVrK1NldFVOd2Y2aXRW?=
 =?utf-8?B?WDUxQWwxMHJkMm5PRm5NMVJwRmNQekgzdkhyZlN3VERpQUd5ZXFicDlhQWJX?=
 =?utf-8?B?WGJ5cWREUVRaR28zWFZoM2JyZHh0aHFaOFhjVHEzSm1xT1BQSkZwZU0xcFVD?=
 =?utf-8?B?NUVTOE9jc0tXZldjejdPcmdNalhrVnlLcXpGSHlwSE1ra1dheGxQQzQzaEtv?=
 =?utf-8?B?VVJTTFQrY2ZUR0tmUFFCT2c4WjlnTmFobE9zaHFZMjJpa1FlVDNtd3BhWU5M?=
 =?utf-8?B?MTVHVms2UlRWTjVmMHlMYmF2U3ozb3BvOWNCMjdqRE85Kzd6Wm5va1RmcjVv?=
 =?utf-8?B?aDFDRFpnMTU2UTRkdzI1ZjVac0NOS3FUZG5pVGZqUWxDMnRGdmQ3QVJleHFs?=
 =?utf-8?B?YW9kcG1DY0FXOHJITnJOVnlDUjFtVGFSa3FXZ1RTd0NTVGJKZXJqSzFIWVo4?=
 =?utf-8?B?TjEvc0J1UTFaeHVtKzNtaGEwMHN1SXNKWnJmU0xUVEhNYlZCTk9kU0ptaWls?=
 =?utf-8?B?ZEFPRUxoWkFtcGNsbk9CcUpRTHhlNmxpVHBjRWdVdVNWMHFrdmFkYWd4eFNq?=
 =?utf-8?B?VVptcWl4OW50MDJzNUJ1TS9NSHphOHNZUllzZjIrNFkzKy9Sby8xRTMyeTN5?=
 =?utf-8?B?aUpwR3VnQ1B2SHFXTDNpUHYrVWlYTE5neHVWTXZHUlNnMXpkbXplYVMzamRx?=
 =?utf-8?B?bXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?UGp0UklFNVFsMEZjWjMzbjNyNW4wOGI3aTFld0FtcEcvWE5XUDFlbnJSY2Nz?=
 =?utf-8?B?dkVmdThuUnZjdlBNQS8za2R3WEZSdlRHSklwZWVyTStpUC9hVG1Fa3pIc0w1?=
 =?utf-8?B?OE9VRUxjeExuSDd0SmJrSXp0OUdLR0w0VTNlUmgyNmFMSHdjZDBPQW1UV3Z1?=
 =?utf-8?B?WDBJK0M3ZlA2NVBpeVhzZFVxZThIc21CM0ZkT3BFUDlScCs1WDhrZm1oUTE5?=
 =?utf-8?B?ZjdqbnhRcG1wSVdCaWlyZzg2TS9SdmZwYmtvMGtrWGNJMGRYQWo1OXJzOTdY?=
 =?utf-8?B?eVh3cVU5cSsyWVFoKzNlblRjWCtDUUZIcVN0ZnNkK2dJVkE4RURsWEF1RnJ0?=
 =?utf-8?B?eXQrNHZoLzhEdExLRVhBVUFqUC95VFVpeXByUkN0M0VoRzgxZnZQMEFFVVNr?=
 =?utf-8?B?SGY4ekpGcndLOFJMSWx0OFpiQ2lOUEdja292MWpIVlZaWXp1dTVWOE9hSEEw?=
 =?utf-8?B?cXhpR2p1SzAyYjZBT1BuVCtkbGcvOWhhZUR6M3RGQktrODBCaFQvQkJ0Uy9S?=
 =?utf-8?B?dW5QbDhIeHFuc2NSS2g4RVJhUmN3RFBhTlpNVVEwTlI1MVFEYzlHVHhZM0w0?=
 =?utf-8?B?V1pRQ2FmZVBUSGlRaHFoYy96K0VsVXFKbVFkQXo4SDFCWDNmLzVTYTBQTlB5?=
 =?utf-8?B?ZWZZTVorTjhHRHlVZ3dsSC82VVJIRUxqY0pMRlFkRmRhVTJLNm1Pb28yWHpM?=
 =?utf-8?B?cXpsRGJ6STFQZi82bkdRbzBMVWMxOEZLeFVoU3BPcHExWGNwREN1STluUnlt?=
 =?utf-8?B?UU1lUmRIMnhiVlduOEE0RHVwVkRwTVozUHFvMmVQVGE2VTY0Q3o4SkZhcmQ4?=
 =?utf-8?B?RmQ4OEp4VXpkQXRiaVF6S1lFdFNLWHd4YnYrY2ZvT213cXBWdXd5V0diS2lp?=
 =?utf-8?B?Mm91Vk4xWDdaTXh3UjlSamg1VTVjNVpwd3k3dDR3M1c1TFVsSURLYndCNFI3?=
 =?utf-8?B?ZnFod21yQnZUbEJCcjliazkzWDRYSHJZUGRGMzFtQldGZksxTHloVUMxTVFF?=
 =?utf-8?B?K3lvQ1phV3h1SDVJNTFMd1VRVWJNdjNqaExOaGEyTmNkMlFxLzh4TmhZWE96?=
 =?utf-8?B?SFIxUEVueUIxZFEzcWxoeWtxQm5ENDl1ME8rajhXQ2t2Umc4cGhYalpOdlow?=
 =?utf-8?B?b2RLcERudjNNTm5SRzh4algwUzEySUdpRE1ta3NmS01taCszSEJhNUtwUmFR?=
 =?utf-8?B?RkIzbUxxQnFON3EweGU3NzJNZGNhR3FUUFdnU0tFeVhEbGV3cGZWMmlLanQ2?=
 =?utf-8?B?bmovZUI2OUZ2Q0JucU5KbXZ4WnFmR2R6U0cvZzdYTkZ6ajlpZHJ6N0lzZzB6?=
 =?utf-8?B?cy9kWkZ2TjNoMVduRW45NnBBT2JxbUhnYmhGS2haVlNaYVBZdVNJOU9TY01w?=
 =?utf-8?Q?ywUVzyoTcaYXOVD8ToSaspVdH9sDaFhc=3D?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 413232fd-ca71-4aca-303a-08db0f357693
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3623.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2023 09:17:30.2754
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8rpIXhUWpDuHEFRAt2TO3zDg7M2doRlDOGtBIJzOt5ENCbGhVAyE52MJGwykKkiivxOaq2VOFjsmy7xJUt/saYiDk3CDhsIZEpkxKBghzFk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR03MB6617
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 26/01/2023 8:08 pm, Ammar Faizi wrote:
> On Mon, Jan 23, 2023 at 05:40:23PM -0800, H. Peter Anvin wrote:
>> So as per Andrew's comment, add:
>>
>> register void * rsp asm("%rsp");
>>
>> ...
>>
>> "+r" (rsp)	/* clobber the redzone */
>>
>> ... as the right way to avoid redzone problems.
> I played with this more. I found something wrong with this. This doesn't
> work for me. The compiler still uses red zone despite I use "+r" (rsp).
>
> What did I do wrong?

Well this is a fine mess...

https://godbolt.org/z/MaPM7s8qr does the right thing, but is now
contrary to the prior discussion regarding calls in asm, which concluded
that the "+r"(rsp) was the way to go.

Furthermore GCC regressed in 9.0 and emits:

  warning: listing the stack pointer register 'rsp' in a clobber list is
deprecated [-Wdeprecated]

which might be the intention of the developers, but is wrong seeing as
this is the only way to say "I modify the redzone" to the compiler...

~Andrew
