Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E92FE68CE65
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Feb 2023 05:57:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbjBGE5h (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Feb 2023 23:57:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjBGE5g (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Feb 2023 23:57:36 -0500
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 06 Feb 2023 20:57:34 PST
Received: from esa4.fujitsucc.c3s2.iphmx.com (esa4.fujitsucc.c3s2.iphmx.com [68.232.151.214])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C17A317CCF
        for <linux-kselftest@vger.kernel.org>; Mon,  6 Feb 2023 20:57:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1675745855; x=1707281855;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xaPgB7N9OSPS0UDLvlg4VAl30+vqPcvz2yRlMjCpAWk=;
  b=RhvfdYx0Fha75kVtFnW/1z7Xq34cq0s6MwKXuqlII74zdYl7hNr+BzfA
   J1zHXTA6g8DSjpAnJ9BeBOjfiOs7IthvbETtD2YJEB2E6vKjtTlXdHIf4
   fk2i437XQkjsl7C0Pdo1DPwl+H+DfcRPQTI8NE3BFRMZURpJDqMbb8KzO
   +AH4hmVSW9CjLU/o4fF6uzKqbdQ+1QxVIQjjsbeJTApBRmc3t5rFmtJxo
   HdkvoXecF6XXNjTO0G0PnW4RdgKNWqRWrqbVwYYyyHeqhP6KbfQGAQtPT
   55yMHb8yxxclTAasKEEhovisxde+lgPsC2v8AuFqt1MbYjJxYxowNZ9jM
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="84154824"
X-IronPort-AV: E=Sophos;i="5.97,278,1669042800"; 
   d="scan'208";a="84154824"
Received: from mail-psaapc01lp2048.outbound.protection.outlook.com (HELO APC01-PSA-obe.outbound.protection.outlook.com) ([104.47.26.48])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2023 13:56:27 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cUXgb+gqhXMswU1A0/9kNReUxveKpEDoLmvLwberjZnnUDNPqYAkggmZ+gsbDhLLO1VRz9NHBXxI39AM01mo0UBJ9Ejx7p7M8UKY0bfmerCMhuTx3RwTDiI7B2Yj0BWiR6Z0id/iYjZCbfV6dT6gunNYtnGVdIATtF0s4f2gLWemtWeXgH6d1tUQKq/nWQg+KSoebEO7/VTQNNriH3MIOqJ39fku8Zh6FiGhiTVDYbkwm+KVEM+/scMRAiqbKn3MvMnnew7PaH+4h+tnc2Deqgn8rGCi+EghNZcBQzAk4gtjGpRz2OnQpM6pcv+qfCTfw1JTnkKKM8pNICAtl1PeOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xaPgB7N9OSPS0UDLvlg4VAl30+vqPcvz2yRlMjCpAWk=;
 b=OfI25TlVhtaBx37TCVRYdcRqDN084xJ4MPOrImjgh1DhpC9ZArt/Ipl0KqFb/UcfThMLKvYasndC3W1uGze/uibJSE3zRT9p4lktvbXT/jXRL65Ezj8KTRvM3I0LC0+qxvVi7plSYozUWUe+grFc66Zu2kmCr1Xdf43aNTJCgoW9HiIDorzugQXXD+jOSd0aGFxS6b0pFJsM06NlGAMICR6Hu2VZ5cTgRud/Vvn/Sxyj4sSZLiQwQDWCaxIYkxjywLid5TC7FXsVkeMir5StDePKpdDjpV7l0rALg4C6qh8NTjx/52uOExZZPKCf2ldEkmkSu/Vct8SEPuALJmbmzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com (2603:1096:402:3e::12)
 by TYCPR01MB9291.jpnprd01.prod.outlook.com (2603:1096:400:193::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.35; Tue, 7 Feb
 2023 04:56:24 +0000
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::2d81:9d85:cd8d:e41a]) by TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::2d81:9d85:cd8d:e41a%8]) with mapi id 15.20.6064.035; Tue, 7 Feb 2023
 04:56:24 +0000
From:   "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>
To:     =?utf-8?B?J0lscG8gSsOkcnZpbmVuJw==?= 
        <ilpo.jarvinen@linux.intel.com>
CC:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: RE: [PATCH v6 4/5] selftests/resctrl: Cleanup properly when an error
 occurs in CAT test
Thread-Topic: [PATCH v6 4/5] selftests/resctrl: Cleanup properly when an error
 occurs in CAT test
Thread-Index: AQHZNTfwUctSaAnC40SoDIvwW0nv4a7B1qIAgAEfUuA=
Date:   Tue, 7 Feb 2023 04:56:24 +0000
Message-ID: <TYAPR01MB6330A24D0B7B52567453FF388BDB9@TYAPR01MB6330.jpnprd01.prod.outlook.com>
References: <20230131054655.396270-1-tan.shaopeng@jp.fujitsu.com>
 <20230131054655.396270-5-tan.shaopeng@jp.fujitsu.com>
 <a9ab65a6-f750-7fd9-99ba-1cbd15427d2c@linux.intel.com>
In-Reply-To: <a9ab65a6-f750-7fd9-99ba-1cbd15427d2c@linux.intel.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfRW5hYmxlZD10cnVlOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJh?=
 =?utf-8?B?Yy1hYjRkLTNiMGY0ZmVjZTA1MF9TZXREYXRlPTIwMjMtMDItMDdUMDQ6NTQ6?=
 =?utf-8?B?MDFaOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0?=
 =?utf-8?B?ZmVjZTA1MF9NZXRob2Q9U3RhbmRhcmQ7IE1TSVBfTGFiZWxfYTcyOTVjYzEt?=
 =?utf-8?B?ZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX05hbWU9RlVKSVRTVS1SRVNU?=
 =?utf-8?B?UklDVEVE4oCLOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9TaXRlSWQ9YTE5ZjEyMWQtODFlMS00ODU4LWE5ZDgt?=
 =?utf-8?B?NzM2ZTI2N2ZkNGM3OyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1h?=
 =?utf-8?B?YjRkLTNiMGY0ZmVjZTA1MF9BY3Rpb25JZD0yMGM2MDIyZi1mOTlmLTQ2ODct?=
 =?utf-8?B?YmI4Mi0xZTFhNDA3MDUyNTY7IE1TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00?=
 =?utf-8?B?MmFjLWFiNGQtM2IwZjRmZWNlMDUwX0NvbnRlbnRCaXRzPTA=?=
x-shieldmailcheckerpolicyversion: FJ-ISEC-20181130-VDI-enc
x-shieldmailcheckermailid: 307e8693aa1f49a5abfd1c83e54ba19e
x-securitypolicycheck: OK by SHieldMailChecker v2.6.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYAPR01MB6330:EE_|TYCPR01MB9291:EE_
x-ms-office365-filtering-correlation-id: 903c7fa2-931b-4c62-d793-08db08c7a9dd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pefagd5j0gTj4jC0arVr8zyOsdDnbSDjYgTy0Ypfu83ftjEzm8Mg/9EaHQ6QgygSdGgsYr+I97UcCPIiLh7sJpxOsHZ9770EEOonmahQCfIq2JaX7QirYZaY7zN4ss63GcF/AaaInX78Cz7FWoEhUkfLCfzq/b79G1tUt3IcFQs8ItauSQFN4Nf5353d0lkk6hiq/kzglUpHaIMs4DLNB13iajGhGtZ4zwlT3MXLFZlcWJmX5CeeqdVGWy1Ed6X+e/475XJvVI90zBJavj/ubp9Xp+sQhJ37U0k4sHX8zH+UfLawOYGc4YhNx3PJlEf33LHWl+qlFME4KgCmNT60A3pXH0dDiL/mVkxYIMj98qd0cu91P3aWboTBBsxOsCvxVSEfIBgiiKAWtrvE46ObNLeZBmhmgA4hUkMKh6BXrZ+IgLyRK0ft+n0kj+SHEEvK0C8UrCuqGgI/I3/EMhqM9Prj8igPKBv1akyNZ5YZejRHCGewMS2payBcI00geDFse/TCOoZp/cjlz8/P98N5C2yXZCsOrik/rWs65JmN/cMW69INoXcgAT7vNusA5ggEICrSs5rIsRb0uohhds84GdQ0rLQB3yC2Coh8cjU40wgtpZij3kbOpR9tJ9OjIGV383D8giD69QJiriKq9Q04mSdkTz77ZJrAutzhnx19qUbgr3MyDHnFT8rnHObSLv4ZrY2JeEiTsgTXAlt/DnvPXoDr0elS1m4lkOTZYVROy42iBsLPpNcZATW866GkLzJ1nwbb2FOulCzcTOnaWeNv2g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6330.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(136003)(396003)(346002)(376002)(366004)(1590799015)(451199018)(5660300002)(52536014)(33656002)(85182001)(2906002)(86362001)(41300700001)(8936002)(38070700005)(9686003)(316002)(186003)(54906003)(66446008)(122000001)(38100700002)(6916009)(66476007)(66556008)(66946007)(64756008)(478600001)(8676002)(82960400001)(1580799012)(55016003)(4326008)(76116006)(26005)(7696005)(83380400001)(966005)(6506007)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ci9acGZHOXJUenRUZVE2L3YyVXFGaFdkSitqTnNJZW5MZ21wMC9NWkVDb1FX?=
 =?utf-8?B?Nm5XUXY1YVRCOElaWkV5M1RnbHovaTVicFBvMXFzS3doYk93ZUtYS3BpemtY?=
 =?utf-8?B?NnJDOW00cUVTZDhGSU9PMkMyeFRMU3lMcGsrRytTQzF6dHl6UEhSaGhFcFpD?=
 =?utf-8?B?NVVPMEdTdHFDTTIwYXpFMk5vVG1veDltOTY5SDZKMDhHQjF4N0FTSThKalIx?=
 =?utf-8?B?V0JxWnluTGFNcGZmbGozVmZidGNtL205Wm83SEZSRVdqejVSVG53NHhjV0RP?=
 =?utf-8?B?UU8wRUt6dkNZYU8vdWxsT0dyYmxKa285anhqRnh1WTZFb1NaOGdYZVR3U3ZO?=
 =?utf-8?B?L0xYejYxVDNnVlJYc3VTWXBSRXdscWN5NWNHMTJhVkZFUmxmTWozVnJPa1JM?=
 =?utf-8?B?bTRyMWVjL1JOL09uN080T1Q3RWhxdThhSC9kc0JkTGlpZGpRZkhrc0g1MFIy?=
 =?utf-8?B?WnpSY0g4bzFlaWFQOFRTallHckVrVUNRM2pjSlg5S0IvQ1hjYjRab09Nek5B?=
 =?utf-8?B?eUx1OUE0QWlseDRpOW9haFRjNm04TEJOY05SSG1LdXUrTmVHWTY5TzYyc0xN?=
 =?utf-8?B?UXVobThCLzZrOEtrV0ovUUtXK2RYYkZrT2xXaDBFejNFYXNkM1JnYTFUbTA1?=
 =?utf-8?B?R3dnVVVBUHlPY1NuZVdSZkxPaTdYa2ZqZXJSQTJobndERy8yZmU2dlMrRUFn?=
 =?utf-8?B?Q09aclJIYjBsYzFkdlBBS21rVldKck82MjYxSmZYQjRFNmZDVi95OWdhNGFx?=
 =?utf-8?B?NmVQaGVpeTVvNFMydGZmSEpiR2JIVy9IWllKV09zMDJGdm5TQlJHTmthVTVi?=
 =?utf-8?B?WXliVkpWMUVoNU5Hb1BHaHdSdnZzUFVwU0JjVFgvR3ZneENSZkttVWtobXNR?=
 =?utf-8?B?VGR3UTNZY3BFTk9OME5SKyttS1BPcGhhWC9GaHgvbHJrejR0OWhrRVY0aFhx?=
 =?utf-8?B?SmNmNy95V1BNOVNhdExXQ2g4L1o3NHZGRDVaTVBtQ3NoLytMZHk4MG1zQmgr?=
 =?utf-8?B?MHBXRFROSVJCN1ZsajBuWXpkemxsNEZZSk9BYWR3Z2JRUExva3lLQkNqNFh5?=
 =?utf-8?B?N05EZzd6ai84bTdJUC96MWQ1TjlTd0hUWGNIbWJWTzdLZ3ZJY1VtSFNWbVZk?=
 =?utf-8?B?UFZrVk51SC9lRFhGRk8renhxbFpiUEZlOTVoUjNqcERkSzhLc29EOFdTZjVF?=
 =?utf-8?B?b2RiVUEyV2RTT056U1BOZnB4VzJ3SldMTlpwN0JsZURRb255eDdvSWdyWjd5?=
 =?utf-8?B?WmhNWU94bHQ4WGprVGMzZ0VsNFdzZUtTb0JLTzc5a29YcGNUL2locUVkdVV5?=
 =?utf-8?B?cFBOOTJmd0d5OE5VTVRHUmpDZFZHTE1FSDVFWW1RTFVhTmxyTmovQ2orUGZX?=
 =?utf-8?B?R2plelErWHVpa0NqcU51WXJkaWg4REZHcnphVXNndGx1NGd2SEUyK2NsaS96?=
 =?utf-8?B?RXplV25yRzQ2d1dsV2lOdllwdzBLdnNUa0I5b2E2a1lJaVU2UHJvdUgvdWFT?=
 =?utf-8?B?R2pDRHVvcUdkS09jWVRyZVdOVUFwMkh2cFM0ZEZ0Q1Axai9CWk1vZ1pnSGtJ?=
 =?utf-8?B?aFZaTXcycmJuWUttWFdqSWV2TUNNbk5OMFBPQ1ljUzI0VWUvNmFRNTdaZUZP?=
 =?utf-8?B?S1BiMkV0VlNMYS83NUtvZFRyRDZncHQ5ODhqZmFRd2VLcHY4bjNUYWF3SVJQ?=
 =?utf-8?B?ZkczQk9zY3BTQlE5ZTRrdTlHcnpXakhrVERXOENyNTduQm9QY1ZkR2M0U1M4?=
 =?utf-8?B?QzA3Vm5QdGhUdis2Q0VOd3Z6VC9jQVlBYTlDalUvRG9ITmtXZjZrZmRFM1lK?=
 =?utf-8?B?cENNcWpkNDh4cHh0OVhKWTlvamo2eG9wZjJaNmtyOUFsQ01xRlc4WSt3b0Vv?=
 =?utf-8?B?QUdCVGJHTWF2eXlLbDRDMVNkWWFqM2pVLzJXT0hKeGpBM1dKYzRQQXlhR0tV?=
 =?utf-8?B?dWJiSG9wMDFaWmVXcWh0WnltMkV1WlQvbWgzaVFJbmhOdllpSjlmK0p5U1pM?=
 =?utf-8?B?dEdZaWNQYlVpQytPS3c5OEJSK210TVdXaXFsSTBaVlNFSXFTZExkcXBjTkRK?=
 =?utf-8?B?ei9wUXN6YmpYUS9DTURiQjNXZmFNTzRZaldJcTY2ODVLNGh6eG1jRzBCZDIz?=
 =?utf-8?B?MWVTdXp0ZnRQcTUvMDF2bCs1TFY3WW1ETkVHak5zcGJsT3krVENPajV6Ti9u?=
 =?utf-8?B?Q3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: SXuWcpV7BlexpYH10QtmHbF9CNUt2mHDBFHl259NZYOknjlMZmNjfDvQKF0nHO1iVgUiAGJK9rf9uBqrSPQYXyt8G/HBj0T8UnzMydBYrZ5/3NVai/0dbEHeKUICWtpbi9mdpHNqBljDOyLzx4ZiM8chsni2AJC9/6lDGNYo+Ja0TyDZXD4uUIBWNH94U/VgffyhuoMtgE/Nt4uAYQB2g9B5HkHVKSBnIW6HjCdXlGP3FLQSliuoXlTVBHhI0KrEYxeNXlF8+5JvnKG8CZaJugAQqlgaNFIxNktJqKYjrVs5K7K6qu1sj+NaFoPoQnL9qPYueaFn5EaQnv9Tp2H4ES8oDVDn68GAZRR+TYhiOKnKgpD7AL4lIJVRyKYf/QKfXN+fAASoFvNlbq9CYwe79sSB5AlGCQtSrXEzlFfV3bMwiRdqDS0HTt954TfsbPSXGS1FkmGbcgYAucYI+MjvR8tvPZObQJhXuTOkoBTLaGqulcSi725FS4dZXqKFJ+g2HItC7DJR+OTKAGn2nXaad41e7abBVImATj0OyziSNOHSJBAQTa8FdEcvbcc08LtNF6BgQI8PLy0jacJfka8TQ0tqtVHze35gIa6cJdkd2fui6m5nSw9v5Gbula70dVeJXaGb80CQydmtMMM0IFmVmkVQJFzOgazCxze7zVBpy2TEhD/LGvw5WvlQYNodEo2GDlK8wZli35mI0YHjzXTTOAPYkWsOTKIMU6woPfDIZPn/uOGcW8/UqhDBiiaxBeYU2MArQDSkumwjUgkAjU/WIEqL91DGkRwaHBg0w1TDwN14KRmeEVto6MVwM+iZDDklwckuNYhlSQfmh2afms+QJcWxAO+X5t7XvxBC/BUrk8pZ+U8d2sNDXOZQpGmBKoyN
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6330.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 903c7fa2-931b-4c62-d793-08db08c7a9dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2023 04:56:24.4148
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m9qQCTgWsTkm43ZW/5X5y6XnUlQcQSDK64ijkA0CXtSqq2CLnLQhpVPqZydVDSRcKzsB2sa0jfrNvewKPmQwgWPHhOO6do7KQGxg7ahNze0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9291
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

SGkgSWxwbywNCg0KPiBPbiBUdWUsIDMxIEphbiAyMDIzLCBTaGFvcGVuZyBUYW4gd3JvdGU6DQo+
IA0KPiA+IEFmdGVyIGNyZWF0aW5nIGEgY2hpbGQgcHJvY2VzcyB3aXRoIGZvcmsoKSBpbiBDQVQg
dGVzdCwgaWYgYW4gZXJyb3INCj4gPiBvY2N1cnMgb3IgYSBzaWduYWwgc3VjaCBhcyBTSUdJTlQg
aXMgcmVjZWl2ZWQsIHRoZSBwYXJlbnQgcHJvY2VzcyB3aWxsDQo+ID4gYmUgdGVybWluYXRlZCBp
bW1lZGlhdGVseSwgYW5kIHRoZXJlZm9yIHRoZSBjaGlsZCBwcm9jZXNzIHdpbGwgbm90IGJlDQo+
ID4ga2lsbGVkIGFuZCBhbHNvIHJlc2N0cmxmcyBpcyBub3QgdW5tb3VudGVkLg0KPiA+DQo+ID4g
VGhlcmUgaXMgYSBzaWduYWwgaGFuZGxlciByZWdpc3RlcmVkIGluIENNVC9NQk0vTUJBIHRlc3Rz
LCB3aGljaCBraWxscw0KPiA+IGNoaWxkIHByb2Nlc3MsIHVubW91bnQgcmVzY3RybGZzLCBjbGVh
bnVwcyByZXN1bHQgZmlsZXMsIGV0Yy4sIGlmIGENCj4gPiBzaWduYWwgc3VjaCBhcyBTSUdJTlQg
aXMgcmVjZWl2ZWQuDQo+ID4NCj4gPiBDb21tb25pemUgdGhlIHNpZ25hbCBoYW5kbGVyIHJlZ2lz
dGVyZWQgZm9yIENNVC9NQk0vTUJBIHRlc3RzIGFuZA0KPiA+IHJldXNlIGl0IGluIENBVCB0b28u
DQo+ID4NCj4gPiBUbyByZXVzZSB0aGUgc2lnbmFsIGhhbmRsZXIsIG1ha2UgdGhlIGNoaWxkIHBy
b2Nlc3MgaW4gQ0FUIHdhaXQgdG8gYmUNCj4gPiBraWxsZWQgYnkgcGFyZW50IHByb2Nlc3MgaW4g
YW55IGNhc2UgKGFuIGVycm9yIG9jY3VycmVkIG9yIGEgc2lnbmFsDQo+ID4gd2FzIHJlY2VpdmVk
KSwgYW5kIHdoZW4ga2lsbGluZyBjaGlsZCBwcm9jZXNzIHVzZSBnbG9iYWwgYm1fcGlkDQo+ID4g
aW5zdGVhZCBvZiBsb2NhbCBibV9waWQuDQo+ID4NCj4gPiBBbHNvLCBzaW5jZSB0aGUgTUJBL01C
QS9DTVQvQ0FUIGFyZSBydW4gaW4gb3JkZXIsIHVucmVnaXN0ZXIgdGhlDQo+ID4gc2lnbmFsIGhh
bmRsZXIgYXQgdGhlIGVuZCBvZiBlYWNoIHRlc3Qgc28gdGhhdCB0aGUgc2lnbmFsIGhhbmRsZXIN
Cj4gPiBjYW5ub3QgYmUgaW5oZXJpdGVkIGJ5IG90aGVyIHRlc3RzLg0KPiA+DQo+ID4gU2lnbmVk
LW9mZi1ieTogU2hhb3BlbmcgVGFuIDx0YW4uc2hhb3BlbmdAanAuZnVqaXRzdS5jb20+DQo+ID4g
LS0tDQo+ID4gIHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3Jlc2N0cmwvY2F0X3Rlc3QuYyAgICB8
IDI4ICsrKystLS0tDQo+ID4gIHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3Jlc2N0cmwvZmlsbF9i
dWYuYyAgICB8IDE0IC0tLS0NCj4gPiAgdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvcmVzY3RybC9y
ZXNjdHJsLmggICAgIHwgIDIgKw0KPiA+ICB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9yZXNjdHJs
L3Jlc2N0cmxfdmFsLmMgfCA3MA0KPiA+ICsrKysrKysrKysrKystLS0tLS0NCj4gPiAgNCBmaWxl
cyBjaGFuZ2VkLCA2OCBpbnNlcnRpb25zKCspLCA0NiBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRp
ZmYgLS1naXQgYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9yZXNjdHJsL2NhdF90ZXN0LmMNCj4g
PiBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3Jlc2N0cmwvY2F0X3Rlc3QuYw0KPiA+IGluZGV4
IDZhODMwNmIwYTEwOS4uMzUyNGZhODhlM2E0IDEwMDY0NA0KPiA+IC0tLSBhL3Rvb2xzL3Rlc3Rp
bmcvc2VsZnRlc3RzL3Jlc2N0cmwvY2F0X3Rlc3QuYw0KPiA+ICsrKyBiL3Rvb2xzL3Rlc3Rpbmcv
c2VsZnRlc3RzL3Jlc2N0cmwvY2F0X3Rlc3QuYw0KPiA+IEBAIC0xMDMsNyArMTAzLDYgQEAgaW50
IGNhdF9wZXJmX21pc3NfdmFsKGludCBjcHVfbm8sIGludCBuLCBjaGFyDQo+ICpjYWNoZV90eXBl
KQ0KPiA+ICAJdW5zaWduZWQgbG9uZyBsX21hc2ssIGxfbWFza18xOw0KPiA+ICAJaW50IHJldCwg
cGlwZWZkWzJdLCBzaWJsaW5nX2NwdV9ubzsNCj4gPiAgCWNoYXIgcGlwZV9tZXNzYWdlOw0KPiA+
IC0JcGlkX3QgYm1fcGlkOw0KPiA+DQo+ID4gIAljYWNoZV9zaXplID0gMDsNCj4gPg0KPiA+IEBA
IC0xODEsMjggKzE4MCwzMSBAQCBpbnQgY2F0X3BlcmZfbWlzc192YWwoaW50IGNwdV9ubywgaW50
IG4sIGNoYXINCj4gKmNhY2hlX3R5cGUpDQo+ID4gIAkJc3RyY3B5KHBhcmFtLmZpbGVuYW1lLCBS
RVNVTFRfRklMRV9OQU1FMSk7DQo+ID4gIAkJcGFyYW0ubnVtX29mX3J1bnMgPSAwOw0KPiA+ICAJ
CXBhcmFtLmNwdV9ubyA9IHNpYmxpbmdfY3B1X25vOw0KPiA+ICsJfSBlbHNlIHsNCj4gPiArCQly
ZXQgPSBzaWduYWxfaGFuZGxlcl9yZWdpc3RlcigpOw0KPiA+ICsJCWlmIChyZXQpIHsNCj4gPiAr
CQkJa2lsbChibV9waWQsIFNJR0tJTEwpOw0KPiA+ICsJCQlnb3RvIG91dDsNCj4gPiArCQl9DQo+
ID4gIAl9DQo+ID4NCj4gPiAgCXJlbW92ZShwYXJhbS5maWxlbmFtZSk7DQo+ID4NCj4gDQo+ID4g
IAlyZXQgPSBjYXRfdmFsKCZwYXJhbSk7DQo+ID4gLQlpZiAocmV0KQ0KPiA+IC0JCXJldHVybiBy
ZXQ7DQo+ID4gLQ0KPiA+IC0JcmV0ID0gY2hlY2tfcmVzdWx0cygmcGFyYW0pOw0KPiA+IC0JaWYg
KHJldCkNCj4gPiAtCQlyZXR1cm4gcmV0Ow0KPiA+ICsJaWYgKHJldCA9PSAwKQ0KPiA+ICsJCXJl
dCA9IGNoZWNrX3Jlc3VsdHMoJnBhcmFtKTsNCj4gDQo+IEl0IHdvdWxkIGJlIHRha2UgdGhpcyBw
cm9ncmFtIGZsb3cgZml4IG91dCBvZiB0aGUgc2lnbmFsIGhhbmRsZXIgY2hhbmdlIGludG8gYQ0K
PiBzZXBhcmF0ZSBjaGFuZ2UuDQoNCkRvIHlvdSBtZWFuIHRoaXMgZml4IHNob3VsZCBiZSBzZXBh
cmF0ZWQgaW50byB0d28gcGF0Y2hlcz8NCg0KVG8gbWFrZSB0aGUgY2hpbGQgcHJvY2VzcyB3YWl0
IHRvIGJlIGtpbGxlZCBieSBwYXJlbnQgcHJvY2Vzcw0KaW4gYW55IGNhc2UoYW4gZXJyb3Igb2Nj
dXJyZWQgb3IgYSBzaWduYWwgd2FzIHJlY2VpdmVkKSwNCkkgZml4ZWQgaXQgbGlrZSB0aGlzLg0K
DQpUaGlzIGZpeCB3YXMgZGlzY3Vzc2VkIGhlcmUuDQpodHRwczovL2xvcmUua2VybmVsLm9yZy9s
a21sLzJhYjljYTIwLWM3NTctN2RkOC1iNzcwLTJiODRkMTcxY2JmYkBpbnRlbC5jb20vDQoNCkJl
c3QgcmVnYXJkcywNClNoYW9wZW5nIFRBTg0K
