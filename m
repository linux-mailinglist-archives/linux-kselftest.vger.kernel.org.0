Return-Path: <linux-kselftest+bounces-736-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E3EE7FC0C6
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 18:56:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8157C1C2093C
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 17:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA02141C6C;
	Tue, 28 Nov 2023 17:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="C3wlNMaz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D9A530FD;
	Tue, 28 Nov 2023 09:55:33 -0800 (PST)
Received: from pps.filterd (m0209329.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ASFgiEb020824;
	Tue, 28 Nov 2023 17:55:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : mime-version :
 content-type : content-transfer-encoding; s=S1;
 bh=n2GoiYWtCR8oWfb0DH675DCUlTxOBUww/XG9PKKt/rg=;
 b=C3wlNMazQMfeu0RTae0gr0PgQllhP112cht3XSlENyC0irfuWMmhPEDv88W/yKFhHzo2
 BBb6xVi//PfLgFYxPo7TXa22TgS5gb5na08rl+XCUFhRacHrTHgkPAcDJS9CjvmYxvAA
 GyeOoL+K4yDOCu9b5fXb5oNrDZt6EGPNwnimSd+czDoyq3FSdHOiPXhTU/hNM3Zroue9
 FPo/IFEXrJTrG506e1jQwocIog0cQZDNBgkfvcmbdFKGjB2tu7WNnnjvDcH53zOwcMGT
 hoJ6FdigJXpUqYFxK7iGtUh7bTAM1alucwvyWOu/0jDrdocqoHUGE8HYbewAurS4xjAQ rA== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3uk7k0udak-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Nov 2023 17:55:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lz0yo3E34nTku1Pw5sDr+e1CyddzD92xi3riiJX6qBANyJT2j/nB4ypGJe2zHVFNMj/xdr/mU0xhlyM6Pr+MTS6a77pCk533EeUpoTnGa18Cvgqhk6kqs5XtFHMZaTbZsXFUu9/JNmdU7zDe7JUgV7Wxe9HD7+aMfuSXIzi+Qd5WZpJpNuaQfjPjPJGJi0aegU+1qZKsK1OVLC9r3gP7sAZZVHGxg7SH3ZayvqGjSLvuX/ZVEo7s1IgTJNc2AHU3OlrFKJAh9AVv5+9FnA9pfRqafQbQOJoZu152dXWBHaelvBW1zOjjtKK5QeHsSJggsNQ+O8nzqkTQOk+Q1q7ZXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n2GoiYWtCR8oWfb0DH675DCUlTxOBUww/XG9PKKt/rg=;
 b=bJmV0pCTPhXqijpiYvC50FKKkH+TzJ1fBJDg/CjnSEPJkbmg2H0IBTCemmqnkVyaDOdOPICyRKe7qsMCAsS/kywllpc7bFB3zA/tMfi0RDsdtI9Cx7EW5lFvyDhywpcjIstA3ESLzHKjmo2+8FQYAtgE57ZlkaAe0XZEj7jZFBKDRpPyBHsqPVBraV5xP2tJbu8VQwkBE7ajXIibPPP1gCSf277b86I6UYbD0Xvv0LQ10OkE3OAyWenqLO9K+JdQBm4/JIeihMLmwyxBZU6AnWRkleQ/jCMo0LvNQPOBDiLOPo1zLP9Dqi8Pg91vEwCDwvhu9R7TspzpaaGGk3Ku7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from BN8PR13MB2738.namprd13.prod.outlook.com (2603:10b6:408:8d::28)
 by SJ0PR13MB5286.namprd13.prod.outlook.com (2603:10b6:a03:3db::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Tue, 28 Nov
 2023 17:54:57 +0000
Received: from BN8PR13MB2738.namprd13.prod.outlook.com
 ([fe80::58b:bf63:b6b:706c]) by BN8PR13MB2738.namprd13.prod.outlook.com
 ([fe80::58b:bf63:b6b:706c%6]) with mapi id 15.20.7025.022; Tue, 28 Nov 2023
 17:54:57 +0000
From: "Bird, Tim" <Tim.Bird@sony.com>
To: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>
CC: Shuah Khan <shuah@kernel.org>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Saravana
 Kannan <saravanak@google.com>,
        Rob Herring <robh+dt@kernel.org>,
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
Thread-Index: AQHaIYqHCCVqMV2IwESZQPAOrwlnnbCO2peQgAD08YCAADRXsA==
Date: Tue, 28 Nov 2023 17:54:57 +0000
Message-ID: 
 <BN8PR13MB273808C3B81BABBAADACC6B6FDBCA@BN8PR13MB2738.namprd13.prod.outlook.com>
References: <20231127233558.868365-1-nfraprado@collabora.com>
 <20231127233558.868365-3-nfraprado@collabora.com>
 <BN8PR13MB27384F089C7DAAF06DF9DDECFDBCA@BN8PR13MB2738.namprd13.prod.outlook.com>
 <ee913bc5-c752-4da7-a140-7492f429c2cb@notapiano>
In-Reply-To: <ee913bc5-c752-4da7-a140-7492f429c2cb@notapiano>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN8PR13MB2738:EE_|SJ0PR13MB5286:EE_
x-ms-office365-filtering-correlation-id: 194adf11-3e57-4201-ec8c-08dbf03b224f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 eXxxfiv3SpnLgzv9na8kCHP7+/ZBNUndyu9x00FlvVfhSELYd/+ElJVow8cIxuevFdlMjmMQH/4LkHyTINRsqj+aavnoopLT23iy9yhZEHg5CqaapxOEIMjn1qOA51y0xsZHYk/vG49un7RUg2FnPFryv4N3TksSljTpoLuQ55h+IjTR//CkC7quULy8KsAwTlEW601Ln5CWhQrimh+nUfpVxBxLY5YkzdXkwFKzbl/QH3ZBRF/cqtXm2j3tQCuzM/dY8JprYB/aDVlyyTC63ZOrZw/1uYld7ZjYJjcVYZinEWZYQJMnuzHs4/LM/suBANwiYpw5BvH3FCl/gebebLJaNjX/SwKocmrXUxRZrilmIVNCypIM5FV7LX7lZl45OMsvJ3WYPqlEr3djLkMgvVBhC7hRdS0DYFAni9gKgI4ZWpz/Lnc8dEHWIkyMBvaBk+7Y4qxo0W7uuy8fQUX5xEVknCirROEMSWSaCEdABp+/i6k2qpFNKoRRz/VH3/s9nh/h9xs2ZBFr+YWsODNR4Z+jCR2eFDdd+syC8w97zr5p9wrAk5yVP11/S/xECN3Bum83V9MEVQgTITC+m6sK1w2hXyo5wdPQNFc0c/1ymVl7eFBYvev/7vWiII4p0JQSk9pgbvmeKJg3rjN2LpN4r7BXSIOeRtye2tkhcMC2IxU=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR13MB2738.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(39860400002)(346002)(366004)(136003)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(122000001)(82960400001)(71200400001)(38100700002)(7696005)(6506007)(76116006)(316002)(6916009)(66476007)(66946007)(66446008)(66556008)(54906003)(478600001)(33656002)(64756008)(86362001)(9686003)(83380400001)(26005)(38070700009)(52536014)(4326008)(8936002)(8676002)(2906002)(7416002)(41300700001)(5660300002)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?QTNIakJUQitDT0ZPTTEwbStJaTNrbGxIWEVLdFZwZDVtMUIrTVNtR1NXNEhX?=
 =?utf-8?B?QU05aUxsbm9VRmpma1RMdldPU3AzL1ovc0lKNHU3Q3gybUlZWlVNdlFjcG1J?=
 =?utf-8?B?KzI3U21Fb2tFc3d2QUJ2anRzdjczUTdiTjVYbWJTVjNIbGxsVWFYLzUxSjBF?=
 =?utf-8?B?N1VsTk1RcDF6eFpabGRIcGg5OXlKR1lJZkhxMmNBMXlzTXliRDdhazlqdW9K?=
 =?utf-8?B?bUpDTVNBNmFUQVZSbllpWm01aXQ3MWlITmgwbGNGSmorUVozblhhYkxpVFhx?=
 =?utf-8?B?QXI1NVpsL2I0Z2NyVlBYcDNZT3Zyc1dXNTZRSlpuMnVrNzRJOGlqTnFhQ1FM?=
 =?utf-8?B?Qm4xMzFmZThSbUJyV1lHN2NBUmdHYTM3UWFZWDBiNDBKbmVWMjNEcjdtdE9O?=
 =?utf-8?B?Q1AxK1Bta1ZjSTllZXErWXVBY2Uzc3czd2Zqd2pVODY2S0x4WkdZOS8vaGw3?=
 =?utf-8?B?QXMrTi9rRU0rYlFFanJuOEhEWmhxMDlpUXI1QXN1L0NaR1V2M2ZCUk5pdG5a?=
 =?utf-8?B?MERzRUloNVdUcDVqblFZUjlZY0wrRVBZb1RIN3ZVc2JuSU1ldyt4Wit1dks5?=
 =?utf-8?B?SGpXU2tVZlBuSWp0TER0UVZEcEFYaGJvZUZNNlhFRXIxWjRtSHNhM1duRHJQ?=
 =?utf-8?B?ZlBDNFFSSERNZ3dXdmZyN05tMW5QbUJyaW1XOWorQnVCOU5NckhXYzl4a2NI?=
 =?utf-8?B?UElvREJyU3ZYSmx4N0t5N25URVVmUzErVG9Edm8weXl3cEhpRU96TjUxWit1?=
 =?utf-8?B?Qm1YVUJFSnZESHQvSk5CZkR5VGV1SXFNS1g2WEhoYmFoUmR1enJCdUM3TFRv?=
 =?utf-8?B?R1lFQXBxdFlTZjBSUVhwNUFKZWpZK202RXQrUXFzUUxUTnNHdm8zTnNHVTZo?=
 =?utf-8?B?ZzRaNW1KclJPSk1RZTRBQi9vK1ljZkg1TERwcGRkcFZsM0FFVE42V1RET2hw?=
 =?utf-8?B?RGlPY2JxWENYQzVpSVYvL0lET0M3QXZOM25UQXh3YnU3OUVUNWY3NWFRdXQr?=
 =?utf-8?B?MEkzVmtlekdocWVBL1BRczkzR2VjYmcrY3pSNy9HRENmQkFPMWFoWjRyM08w?=
 =?utf-8?B?STRTUzI2aGtzM3c4YWtYVDEwbmVRSmZZbzl3alplUmIzVjlDUDZkdk1Td2tG?=
 =?utf-8?B?OUtRaDM3cFMyVXdRSXNkbm5hekRkQTdqU3lpUS8xdng3VkREeGJ1TUNJNXV6?=
 =?utf-8?B?NlNseXBVRXBhS1RzTGEwRmV0alFYdVh0VDRUWTdoODRvWmxKQlhrdFJSZzVa?=
 =?utf-8?B?MWFVVEMzVTQ2NTZUNjNKWDN1eVFMaTlHbFM4clE2ektxcDFGZ3dNMjBlamZH?=
 =?utf-8?B?eHpUYWJMai9tbENxaytsSDlmVnVaRjEzMExhcm9HZU5mU0trVkk1Zmd2K3FB?=
 =?utf-8?B?eFN6MXJaT1BqQ3BhTGJkYmo1NVo1Zks3eWVtUWhmQlZXNzVjWDZBYUt3ZUJP?=
 =?utf-8?B?MTRoLzZ2U0RkWnlad2pXMTc2d1BYYm52ZVd4anhUVEYwUWRqanFOM2F5S05S?=
 =?utf-8?B?UDBmeU1rV1BibDRuMWlQRFFGVWZ5ZC8vMjBiTTdJUzdzT1dpd1ZHS0RUd2tB?=
 =?utf-8?B?bXMzaDd2c2QvdUpKYndOVFJWK2ZBWG5TWVdIeDN6QzJzcU1CMFNXY0RhNmJ1?=
 =?utf-8?B?MmRKM2VEZjF5ais1K2tMNVZnSzlUUmhnQUlzRFplSnZ4NkYvZXJlQ1Vmc05j?=
 =?utf-8?B?a05ia2Y1REZoOEt1bUI2aVNQaDlFbC80cWxyTHFGRUxjSUhVdkFRRjFJYk9q?=
 =?utf-8?B?TGp0RzNJdFcwbmsxclRTWXVCbWRFaXd0b05FQ29PU0sxSS9NaHdxUXowYXJO?=
 =?utf-8?B?NEo3aGdCdGVoMUZESmZnc09ablRBSTY2Y0FWd0ZMRklCclI0Y1dyS2lVb002?=
 =?utf-8?B?VEIxdHcyMk80SlhzSUlmNDFsSWNld2RPNjlqSytHNUNLMU5kbHIwMkdXNmt0?=
 =?utf-8?B?a24vRmN3Nzh0akd0a1RMMlFCUTlKUUpsWXFXdlBPTXRnU3daUGRPcmZ6dDVB?=
 =?utf-8?B?SlZDWGFBS0t5b3IwazVQcmNtSkdPa2hGNEcxR0dlMjZtSW1uWW9xSUloQWF3?=
 =?utf-8?B?ZEkzSUYybWlzakJoSFBWa1BRLzFUOVZQYmVaNFpaVXA4ZjgwUU1WeUVGQWtW?=
 =?utf-8?Q?744E=3D?=
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?utf-8?B?QkhjbjUrYWpGVENUYzR3QlhmUWFFb2hjUTlOL3k5N1ZTRmpZdUFsODZEYzNO?=
 =?utf-8?B?NXpidElCTi92Vi9JRlZVQzVBT0Zadk4rU0FLRy9IZUhDM0RMZU1ONkF6V0d0?=
 =?utf-8?B?OXBTc2w2SnVuRStIRDlvOXhBaW5qQmZsYXUrc3VwaUplRWRFMmE0QzBUZVVv?=
 =?utf-8?B?Y284ancxVUxJYm1tcGVmaWh5UTU4WFpNeTFyakJ2Umx3TWY3T0Z5VkZSbEVk?=
 =?utf-8?B?amIzR0FXYWpaS0F4K3RieThXd0tQVk05ZG5ZMHJNVTVNWWRPNUhIYVlMZ2Rr?=
 =?utf-8?B?Z2crRFl1ZHFKZ1ZSaWtLVktHVXkvcDlqNUhtRktpbzkvTDAvb2NkbzZaaXNq?=
 =?utf-8?B?ODlPNFV1ckEwc25zWWZOYnZ6WHp5QjBlZExXT1I3ZGhZa3llVkNnYWJsK0Q3?=
 =?utf-8?B?eTg2aXIwdVVQZ3lYZjh2LzRkKzRGQk05TGI4QmFDQUpSbWRoZkFQby9ZTGR2?=
 =?utf-8?B?T083cnhNakdkeEJNS0JNMVlBUmRqSGpGNzkxbFI0WEMyWEtGWXJwaTFLWmdE?=
 =?utf-8?B?S1RERkNvUzVvY3FYK1Y4YkVzZmkwNVYvZHp6eEhYSzJ4eTBKVDNvRXdEZTJJ?=
 =?utf-8?B?b1ZkYVdweThHSXFTKytIRmF4Zkl1UnpJMW5mbmlITEJZbzM1ZFQwZkhoV04z?=
 =?utf-8?B?NGZCYk1SQWE0bE5hMlFCR0s4YXAzaW4rL1Y1TmgwTW02OWpodXhuZ1M2N2gr?=
 =?utf-8?B?NGNuU1hyQnFuOFNLWHFOSHlKbFJBcUNuWTY3ZjhZLzFPcGhIZXBDWkR5clYx?=
 =?utf-8?B?Vk4ySHNPSXM0SGhNRjFkdGxPeEpNeDFqMkRmc2RXVFJ0NUM1R25MUE5lQ0Rp?=
 =?utf-8?B?SzhLQUV0UDZGSjZlK3Eyc3d2VGd5eEUrUXlud1NBSGdmK0wwTkU4cXJBMlAr?=
 =?utf-8?B?Qmk5TzVwdFZReThTSERKUTFXanp1cnhqSmtFMDQxY3dLcjRCZkhZNVpqVUZI?=
 =?utf-8?B?RkV1RmdpaEo3NSt5ckRQWVZ4UlFNc25sc3dEdmZOZGplWTNkNER2SGlyNmxD?=
 =?utf-8?B?QXJLdHpWNGJuQjJLZ0hWOTRkdi9lTzBFbnIvcU9FZjFlVU5neitlclZ1K2pG?=
 =?utf-8?B?Um1Hejg1VE5oVmorZ1ZCNURDK1MxZGxvZW9HZlB4enRoNVRuN3VaWE5oanJi?=
 =?utf-8?B?dFZIeFFmK2ZYTVlJcXhYelgwV0JteTg2S2dBZ3M4SGowY1hIbFRrUlZQcXUx?=
 =?utf-8?B?V0dVTGZvbGQ2QndoVmZ4NG1seFBKbmQxb0JPc09BOEtla1NraFo3MU1QVWNs?=
 =?utf-8?B?eGV5WWxZK1BFcytxeTZ1cUs1RndwWGc5cnRuQnI5L3V3dFpBV3JoVlNMcVFT?=
 =?utf-8?B?VzhwdURtMjJaU2xpaHJNRURrZzFEVGpzbWFWeDlOa2hSODFsUlFKaUVodFlP?=
 =?utf-8?Q?uvZUtznFvxFO5TqoBSHiRdVdxGJrM+c8=3D?=
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR13MB2738.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 194adf11-3e57-4201-ec8c-08dbf03b224f
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2023 17:54:57.2228
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pt5wq6FAOcyfECliHy/sWMAQrD8XyUUrVOKLkiYmnakzU6yPepPzKHcjE0W1ASBBz6w4ufKkVsVDMsc2YL6FeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR13MB5286
X-Proofpoint-ORIG-GUID: 99TALMrPL7CFVi7jC5wQnmA6TPZru6Ri
X-Proofpoint-GUID: 99TALMrPL7CFVi7jC5wQnmA6TPZru6Ri
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Sony-Outbound-GUID: 99TALMrPL7CFVi7jC5wQnmA6TPZru6Ri
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-28_19,2023-11-27_01,2023-05-22_02

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBOw61jb2xhcyBGLiBSLiBBLiBQ
cmFkbyA8bmZyYXByYWRvQGNvbGxhYm9yYS5jb20+DQo+IE9uIFR1ZSwgTm92IDI4LCAyMDIzIGF0
IDEyOjEwOjQ2QU0gKzAwMDAsIEJpcmQsIFRpbSB3cm90ZToNCj4gPiA+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+ID4gPiBGcm9tOiBOw61jb2xhcyBGLiBSLiBBLiBQcmFkbyA8bmZyYXBy
YWRvQGNvbGxhYm9yYS5jb20+DQo+ID4gPiBBZGQgYSBzYW1wbGUgYm9hcmQgZmlsZSBkZXNjcmli
aW5nIHRoZSBmaWxlJ3MgZm9ybWF0IGFuZCB3aXRoIHRoZSBsaXN0DQo+ID4gPiBvZiBkZXZpY2Vz
IGV4cGVjdGVkIHRvIGJlIHByb2JlZCBvbiB0aGUgZ29vZ2xlLHNwaGVyaW9uIG1hY2hpbmUgYXMg
YW4NCj4gPiA+IGV4YW1wbGUuDQo+ID4gPg0KPiA+ID4gU2lnbmVkLW9mZi1ieTogTsOtY29sYXMg
Ri4gUi4gQS4gUHJhZG8gPG5mcmFwcmFkb0Bjb2xsYWJvcmEuY29tPg0KPiA+ID4gLS0tDQo+ID4g
Pg0KPiA+ID4gKG5vIGNoYW5nZXMgc2luY2UgdjEpDQo+ID4gPg0KPiA+ID4gIC4uLi90ZXN0aW5n
L3NlbGZ0ZXN0cy9kZXZpY2VzL2JvYXJkcy9nb29nbGUsc3BoZXJpb24gfCAxMiArKysrKysrKysr
KysNCj4gPg0KPiA+IE92ZXJhbGwsIHdoaWxlIHRyeWluZyB0byBtYWludGFpbiBhIGNvbXByZWhl
bnNpdmUgc2V0IG9mIGJvYXJkIGRlZmluaXRpb25zDQo+ID4gc2VlbXMgaGFyZCwgSSB0aGluayBo
YXZpbmcgYSBmZXcgYXMgZXhhbXBsZXMgaXMgdXNlZnVsLg0KPiA+DQo+ID4gSSdtIG5vdCBhIGJp
ZyBmYW4gb2YgbmFtaW5nIHRoZXNlIHdpdGggYSBjb21tYSBpbiB0aGUgbmFtZS4gIElzIHRoZXJl
IGEgcmVhc29uDQo+ID4geW91IGFyZSBub3QgdXNpbmcgZGFzaCBvciB1bmRlcnNjb3JlPw0KPiAN
Cj4gSSdtIHVzaW5nIHRoZSBuYW1lIHRoYXQgd2UgZ2V0IGZyb20gdGhlIERUIGNvbXBhdGlibGUs
IHNvIHRoZSByaWdodCBmaWxlIGNhbiBiZQ0KPiBhdXRvbWF0aWNhbGx5IHNlbGVjdGVkIGJ5IHRo
ZSB0ZXN0Lg0KPiANCj4gPg0KPiA+IERvIHlvdSBhbnRpY2lwYXRlIGEgY29udmVudGlvbiBvZiAg
PHByb2R1Y2VyPiA8Ym9hcmQtb3ItcHJvZHVjdC1uYW1lPiB0dXBsZXMgZm9yDQo+ID4gdGhlIGZp
bGVuYW1lPw0KPiANCj4gSSdkIGp1c3Qgc3RpY2sgdG8gdGhlIERUIGNvbXBhdGlibGUgYXMgaXQn
cyB0aGUgc2ltcGxlc3Qgb3B0aW9uIGFuZCBzaG91bGQgd29yaw0KPiBqdXN0IHRoZSBzYW1lLCBh
c3N1bWluZyBJIHVuZGVyc3Rvb2QgY29ycmVjdGx5IHdoYXQgeW91IG1lYW4uDQoNCk9LIC0gSSBz
ZWUgdGhhdCB3YXMgbWVudGlvbmVkIGluIHRoZSBvcmlnaW5hbCBzdWJtaXNzaW9uLiAgSSBzaG91
bGQNCmhhdmUgcmVhZCBtb3JlIGNsb3NlbHkuDQoNCkl0IG1ha2VzIHNlbnNlLiAgTWF5YmUgaXQn
cyB3b3J0aCBtZW50aW9uaW5nIGluIHRoZSBjb21taXQgbWVzc2FnZSB0aGF0IHRoZQ0KZmlsZW5h
bWUgaXMgdGhlIGNvbXBhdGlibGUgc3RyaW5nIGZyb20gdGhlIERUIGZvciB0aGlzIGJvYXJkPw0K
DQpUaGlzIGNvbnZlbnRpb24sIElNSE8sIHNob3VsZCBiZSBkb2N1bWVudGVkIHNvbWV3aGVyZS4N
Cg0KVGhhbmtzLg0KIC0tIFRpbQ0KDQo=

