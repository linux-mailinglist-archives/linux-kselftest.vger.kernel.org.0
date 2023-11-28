Return-Path: <linux-kselftest+bounces-685-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D9D7FAF1F
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 01:36:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69C9A281977
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 00:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68CB11365;
	Tue, 28 Nov 2023 00:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="A4OvNYtL"
X-Original-To: linux-kselftest@vger.kernel.org
X-Greylist: delayed 1507 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 27 Nov 2023 16:36:32 PST
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B24341A2;
	Mon, 27 Nov 2023 16:36:32 -0800 (PST)
Received: from pps.filterd (m0209318.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ARMDE4j025363;
	Tue, 28 Nov 2023 00:10:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : mime-version :
 content-type : content-transfer-encoding; s=S1;
 bh=MRn2eyz7OH/SrlGvAzHCG56tDOQonGKFHRM+I5MFfuo=;
 b=A4OvNYtL+Gh0zcFCcPKRte3Pmtr6oTI5GhJzBXzZKKT3W0UDQ27VUYmrIeGDPS74sTFy
 dEgojgMZlRNU1+sy8mCiv5ry5G668YfV57i+67vgai+Iaqg/HIlA4CotstXLHuDrc8lO
 hZPMLnAZsb8fGke347LJ+HE7A/hvXcT7GQ6PjIeRqthg3XemM8hQE5Oyr12sGMO+2LL9
 IgQdTZrUAuKz9xuoWBzmAcEKtYHndkEFet/rnn9je+9kR3SvMaJVj62rghmqJgBDQ6IY
 wEz5BtPCtIuvhqBXfzFFAcEmVBi8h7m6IXlBpn26aOYXiCzYEL/eWGFz8vVnyo7pGEYB 0Q== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3uk7g6a76w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Nov 2023 00:10:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LrhV2mi+mbraYuK+mbX5NHKQ808t0isya3WEVTtUgUk23s7K5Ydl4QAQw2+WcUJn2SUSCRIIFpvUxQ7dhb7AJhHdWCQoDMukoSn3oJdJrsdEKabTJsrz6F8GJ4+yptBEV5ve1KbgtVKoSEJ8350hV37NM47qiw0+SQqYZfzplx3qEfs0gLQ7ayjeArtCfD3/JW4WgqpD7WKB1IfNMhR+f3cuOGhs4kZDlriZlKOJZyaqO7OyvKI5rDvm18GAgU118dEHMX6FwCILquq0+BFbE0CNLms21/72BTH/W35yVjo1uOseIB44CLhkVS6o/J7vhrXq+Fc/1tQwAn7wu6oWWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MRn2eyz7OH/SrlGvAzHCG56tDOQonGKFHRM+I5MFfuo=;
 b=UWa4JE2T8j4REB90dBqR4WFA3xPrm2Z4nY8QCgNvDr5rjmUU/yqAP5F/lMJ2qydPFJJQzAjoHjiuOk82FaLEv8iA0jG+DpIce9V3n3m5jW4ljGgSQHgZYk+RKYE3VVQAtTqQfwDHUa/HwvziZV1JX03mybfcj45OiigITzi4eRGobNDUyVA9j2KX8e1Z8FCp65MNBkVpHNAnXf/SVW3msLUWzkoqtAmxABsH9xF755tV5luslkOeqNQcuGxEzAL07NeVH7sfb77j1oVK+YjPOuOxrl9UQ6Jli+2JCWOj+AJsO7mQ6cML8bOPssKlfEt3HIfDWdXh0SJmZjE8Sg+cqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from BN8PR13MB2738.namprd13.prod.outlook.com (2603:10b6:408:8d::28)
 by PH7PR13MB5913.namprd13.prod.outlook.com (2603:10b6:510:158::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Tue, 28 Nov
 2023 00:10:47 +0000
Received: from BN8PR13MB2738.namprd13.prod.outlook.com
 ([fe80::58b:bf63:b6b:706c]) by BN8PR13MB2738.namprd13.prod.outlook.com
 ([fe80::58b:bf63:b6b:706c%6]) with mapi id 15.20.7025.022; Tue, 28 Nov 2023
 00:10:46 +0000
From: "Bird, Tim" <Tim.Bird@sony.com>
To: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
        Shuah Khan <shuah@kernel.org>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
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
Thread-Index: AQHaIYqHCCVqMV2IwESZQPAOrwlnnbCO2peQ
Date: Tue, 28 Nov 2023 00:10:46 +0000
Message-ID: 
 <BN8PR13MB27384F089C7DAAF06DF9DDECFDBCA@BN8PR13MB2738.namprd13.prod.outlook.com>
References: <20231127233558.868365-1-nfraprado@collabora.com>
 <20231127233558.868365-3-nfraprado@collabora.com>
In-Reply-To: <20231127233558.868365-3-nfraprado@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN8PR13MB2738:EE_|PH7PR13MB5913:EE_
x-ms-office365-filtering-correlation-id: a7793d92-7404-420c-8442-08dbefa6780f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 5NS1h0s93VHnvAG+jqQnDOpnQ6VkFsjtp/xxGq1M1M1YQU5z5Utcw/0YXxChNSnpS1nplPL7cMwqkiydP95jmLbtB2O4nc/jYZwoBhhHdJwM3vRI2bGpwG+2/mbt8on4oHipVBwZumePvw+qeeNlKZZFxUAyC3WBZExqhVeR5K7SbhgBVDvW9tfjz7Dl48cjtNvcku9qUz6V3o5gGDbJfniXMhitk7K9+9WcHXhCAM9SKYgyVxQ+iTwSSh24XcozYl2JqQIhYuumQiX7yPLR0zSs8ye3sw5OO6pzk3z5+npOuh/edkBrAtwiYZNcqJA/p6X1E2HLfzbGvkU9PLBFh+BFFEsveYWEjRNOQen2eYEsbeD+AYfRk53vCx5ZJM61Od5lqG8BgpiHVhu1+Yo3gF77B4ahDKAfUZzvvrCdvpq6ey5o9Rsh0TUwSQECuZbGZv1k7NCHlYIdjm0CTu+4zIULy9ZXceqx+vdITnzKwgFXXNlSbrneu5/VDyFglQyLFk+Zd53/R3meqKusI305jXiiFGJOQTFXw4tLgo5WakdSzWHqmGlp1hWZnLaXVLO8D2HFexfprSOCxQcw25I6bUA6y+a54TKrBRuUbSivVBAdRnbHCs1/vZG3Q5CJ8FCBiE9TbmAzKxfKIkplxNEHXCRH6/7rzhSjA/M1sNsbN5E=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR13MB2738.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(39860400002)(346002)(376002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(52536014)(8936002)(8676002)(4326008)(9686003)(71200400001)(6506007)(7696005)(64756008)(54906003)(110136005)(66556008)(66476007)(76116006)(66946007)(316002)(478600001)(66446008)(122000001)(55016003)(41300700001)(38100700002)(38070700009)(33656002)(86362001)(26005)(2906002)(83380400001)(7416002)(5660300002)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?K1Vxd2pDUU9NN3JUaVoxNHdGVktpWW9Yb0hrbWN5MEFTcklzajRsNXFQaURC?=
 =?utf-8?B?RU9uVjRSNm9OdjREM1owMlhRdDhKNE1EaGxWQk43STVtSjBzNVRRRDBpUFB5?=
 =?utf-8?B?Q2hkcS9lUk5tK3NNSFU3ZmE5cC9tbWt0SDFwa2p1bWpGTU5CS0R2eWRpSVZp?=
 =?utf-8?B?K0h0QXQ1QVJzSHY0bmlUaG5IOUtSbDhIaHR5TThrV3Rlam1pZmJQblZib0d2?=
 =?utf-8?B?a2I4RXRPVFRIT2JZTjk5TjBzMDBXRnhndDd6NEhqWmRpOFBmRTFyTEtHVUw5?=
 =?utf-8?B?eU5WbkE2K2ZZWVZBZEZZelp3MVhiZER0V05VYk5VNFg2UWZSdy9nVkM0V0lw?=
 =?utf-8?B?QWJwSzliaDBHeGdVNTBEaWx4Vyt4aGtnVmppUHFSR2FReU1TVW1RZmJtSG1B?=
 =?utf-8?B?b0g5cW1oRjBINXFzMmtJZ2ZWT3BDRTNhaVhCTjVnU3JxcE9KZHozdGg5cG1J?=
 =?utf-8?B?UHJzb25EZUNzMUdnU25MQjlJYnhNcS9XcWoxa0dpLzU4SjdoVE1rY1gyc0sy?=
 =?utf-8?B?OEpXdHpqTkV3TDBibHQ3MXFOVzYyazhuQVpPN1hsNzRpTFlYazVFZ2JUaC9B?=
 =?utf-8?B?blRKc1JZcVdhdUhKWHpRYVlDTVRYZmdCQjBJNVNuZVZOaDQzNWU2cG9EVUdL?=
 =?utf-8?B?YnpKUDdEeGRFVnNrcDZFc3oxRFZpbXhaSlVBa09vVDN4Vmp6TWY4TnpKcXFi?=
 =?utf-8?B?b0dkeWYrcjJZRHhETHY4aFpTQldINVdZT2trdG5pNUlONjlqMnBkWVFXWnJX?=
 =?utf-8?B?ZkxwUGF6Yk1nandrbEFObkxXWUU1aWlWQU9uQ2lqSHNxZkRGdnRRZXdNRXlz?=
 =?utf-8?B?dENIeHBGMkRlUmVqZWV1NUhDYUd4Sm5LTnFDWnBKblByYlpkY3dZVEJXelRK?=
 =?utf-8?B?blJYZ2ZhZzY5cXRJOTN0ZVhKNERGR0xtci9zOXhacUhYY1BrRllpa1JIYVM4?=
 =?utf-8?B?VlFxendNc1BLSTcvdmhod3hiY0VrcUV5MkVibENISC9HN2dqY0hBZUg3Q0l6?=
 =?utf-8?B?Y3B3RU5ydFludVdsdVkwU1hrM2V6Rm5wQ1dBVTdmbzhTbG1Ic0p2amNGd3Ir?=
 =?utf-8?B?MEl1dzdYQWpnTVJ4VHdzQklZdk9WWXAyVWp5cnlQd1BkTUVGUlg5SjVwNWl1?=
 =?utf-8?B?S1lHSk5GSnNRMHREVC9JNmpYUFY0YWhZQ2IzNXJwYXZPSFAwZGN1U015Umtk?=
 =?utf-8?B?cDJBNjA3Tk85R1BRM3VyRG1NMkwvTlFHSFJ6anlKRE1uK1VzbmFLN2Z6aGVF?=
 =?utf-8?B?SW5TYlVQYXdrRERxK0FJWkQwWHg3L0pmZ3Rvc1ZnUGFLS21jZ2g3MmFpQU5D?=
 =?utf-8?B?YnNXNTFJTDZFdlgrK1hTMjJaRklZVVZOci9RU2dSVXBqSlJYaXYxQ2s0cXNx?=
 =?utf-8?B?T05PK1JXaDJwVWpFM0NHYW81Q2t1Rk1vV2x1NlIya0RqbUhoUklLdUNFVmpX?=
 =?utf-8?B?RDdLYjJoZmIvWXRVK292MDN4MjMyUU9IQWNzTjFpaFAzOFFaVld0YVNpNi84?=
 =?utf-8?B?V1Zha25iNU9FR1ZKeTVYUUxIYUg3QnNwQm9qZU1yWENlazRyL1pPZ2ZyZy95?=
 =?utf-8?B?cnVRcjlYdkZtb3JZU2h0NXlzS1k1Z2Q5bG55Z0FKZnZSdWVZSUxyMHMydFhJ?=
 =?utf-8?B?VEc0c3ZNYWpMaVBldllmK2VpeFVrclZIdzNqWkhwOXEzWk4wVzN4ZjlVTjZU?=
 =?utf-8?B?eXpvVkExT1loVXlyNmFzYjlSSndtQ1lXZG52b0RlMXFqempYMUVFZ3lOY2dk?=
 =?utf-8?B?UTRJa09neG9VR3ZDTDQ2NjZTTjB4dW96b3JWZ0lzaEFaWW4zRS9XR1ZuS0pM?=
 =?utf-8?B?dHMwWnBqZ3kyc2NjOFl6NTd6dENJam9oakx2L0UxRHBscWhFeE1Za0xiamVX?=
 =?utf-8?B?ZEtTQW4rQjJBc0RnSEs2NEY0VjF4WHVvKy9rQTlNd1JWVmpjOFRLQzJ4dWhm?=
 =?utf-8?B?SFBVMlRnME9EcnB5cUhIUUdKSTRPUnV3L3Nsbk1PSnFLOFRObXA5UmFUYjE2?=
 =?utf-8?B?ZEtPby9IMzVLYUtkTEIwWnlXVEdsM0JJMkZXUzBxVVVFWjV1NVNWVEZERlZW?=
 =?utf-8?B?c25CK044MkprdmsxQllYZUJlY2hja1loQUFhNWFJSTNlTUZieWpnWE9IeE1I?=
 =?utf-8?Q?z3N0=3D?=
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?utf-8?B?RUdsaUxZS0M1TFdaTjJYQkJwN3YwWW9mQVVDTC9TUmRoVmdITFRkRlJCV3RV?=
 =?utf-8?B?RkpuN3NvOEZtMTA3d3ppWUhvNU5TTndUMlJWT2xwckVPZ2xqTU9Jb3k4Mmtp?=
 =?utf-8?B?aytvMm5wbit1L2R0K1ZtQ3doWTd1MDFyR21KODFzYTFZT0sxT0ZFbE4rRENP?=
 =?utf-8?B?TmpUVjd1cFFka09VbCtvRGhoM3lFQlJmdkIxTFYzUDQ2eUxBNENJWjFqUlpO?=
 =?utf-8?B?U2lGTllzQU41RExvOW91UmMxVUtLUnNFb2tKMTNOVndrY0g4YjhZQ1FrNTc4?=
 =?utf-8?B?OFZqTW9oYlBXR2JOYmVPMXphZmhXbWt4UElTM1dBbWhUcEZzVXhXZ3UzQ1hw?=
 =?utf-8?B?NlZLUVVqNDhrOE9DU2szdmk3RC9VYnFPVS9PN1dKZ0VlN0hxVGZWdHZrcUFW?=
 =?utf-8?B?TUc3K3pGaHhPbTdxSFpoTW5KaVF2ZTFqcTA3cEhvbmxPZFhSM3A5SnF1TzhW?=
 =?utf-8?B?alkveUJES1Y3RGRrR3U3K2RYUXdBUVUrR015dVJwa2dQN2V3dkNUZTdEMXJL?=
 =?utf-8?B?RVpTVUdsRndIQkprLzJNd0k1eGZzbzFCVDhyYy9aU2xGYTZqam90QTlXWm9W?=
 =?utf-8?B?ZHJkM1cxWlVXaFFCYWNoM1o1RjV4UnRDc3V6TmQ5Y2NaSEZRZ2dzNHZuSzVF?=
 =?utf-8?B?aXl0VG1mREpub3M5ZUpOeWpxSEswMXB3NkpueGJWRGhnSmRrd240T1JJMDRq?=
 =?utf-8?B?MnRXUHk3Q3lrcUtnTVlHTGJYamtPUlVSQWFvVzdMaUg5b3R5dG42MENObEdU?=
 =?utf-8?B?bnBrSmlZUGoxeHVMRUM0czJJVzBudzJZM0F4UEtwdUtSSlpmUnpjakw4WkJv?=
 =?utf-8?B?UmF4TU1iVklGNHN1dDZtWjBWWXBBTU14Z2hUcWtXREIzZVk3Y3dGOFhjN0w0?=
 =?utf-8?B?TlkzQjJXWDJmYitjUkR6alMrYkJMbGh1Z0NsN0h4cHR0TjN1VXJRTThLUDJZ?=
 =?utf-8?B?R1Ira05pcnUvV2todksyMkR1Y3JsTER0M24wRlh2OUpHRzZRa3Y1OTAvK0pn?=
 =?utf-8?B?RFJGeHVGSkFJMWIzSHhRaWJscVlaeTlaRUlnWXZ1VEVDSDI4Y0kwMjdrVXRL?=
 =?utf-8?B?V0lIRWtkZWNrczNEYTMzcmc1UElML1VEd0tEbjBUUjIzL2hZUkJVV21uZzFZ?=
 =?utf-8?B?d01uV3loRktXTWJCQ2JTUE1lTHdrL3ZCUzB2d2tzdnZtWG1uUHRqNDk1bHFZ?=
 =?utf-8?B?S0pGUkh5V1BVclZ6TlJHbjViZ290UmN0NXZJRXE4ZVdRT0ZIdjNNOVFSUFEz?=
 =?utf-8?B?c3ZpMnFwUmUzWXUybW9rajFGRnlpRWJteVZPY1dTblR2cFk0dFBZM3JoUUxB?=
 =?utf-8?B?amVnQ05obFA0akZoeWo5ZC9pVVViRVlCUTlNY1Z1cXVPK3FMSUI4MFlPTTNH?=
 =?utf-8?Q?Iv0U0NkTTamqSTmgS0cbFLaCSaMQBwi8=3D?=
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR13MB2738.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7793d92-7404-420c-8442-08dbefa6780f
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2023 00:10:46.0795
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jMqKYkqqSznhw4GAJbSZOvIzrN9HYBbhNpWeA6wBVj4SLjLTcUEBfWSrN4b74FcwCb9J1+2n6o3ahsLbF6WfxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR13MB5913
X-Proofpoint-GUID: fWru3I_Sx1KzvcOT8X9kr-CHOAyX7H9-
X-Proofpoint-ORIG-GUID: fWru3I_Sx1KzvcOT8X9kr-CHOAyX7H9-
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Sony-Outbound-GUID: fWru3I_Sx1KzvcOT8X9kr-CHOAyX7H9-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-27_20,2023-11-27_01,2023-05-22_02

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBOw61jb2xhcyBGLiBSLiBBLiBQ
cmFkbyA8bmZyYXByYWRvQGNvbGxhYm9yYS5jb20+DQo+IEFkZCBhIHNhbXBsZSBib2FyZCBmaWxl
IGRlc2NyaWJpbmcgdGhlIGZpbGUncyBmb3JtYXQgYW5kIHdpdGggdGhlIGxpc3QNCj4gb2YgZGV2
aWNlcyBleHBlY3RlZCB0byBiZSBwcm9iZWQgb24gdGhlIGdvb2dsZSxzcGhlcmlvbiBtYWNoaW5l
IGFzIGFuDQo+IGV4YW1wbGUuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBOw61jb2xhcyBGLiBSLiBB
LiBQcmFkbyA8bmZyYXByYWRvQGNvbGxhYm9yYS5jb20+DQo+IC0tLQ0KPiANCj4gKG5vIGNoYW5n
ZXMgc2luY2UgdjEpDQo+IA0KPiAgLi4uL3Rlc3Rpbmcvc2VsZnRlc3RzL2RldmljZXMvYm9hcmRz
L2dvb2dsZSxzcGhlcmlvbiB8IDEyICsrKysrKysrKysrKw0KDQpPdmVyYWxsLCB3aGlsZSB0cnlp
bmcgdG8gbWFpbnRhaW4gYSBjb21wcmVoZW5zaXZlIHNldCBvZiBib2FyZCBkZWZpbml0aW9ucw0K
c2VlbXMgaGFyZCwgSSB0aGluayBoYXZpbmcgYSBmZXcgYXMgZXhhbXBsZXMgaXMgdXNlZnVsLg0K
DQpJJ20gbm90IGEgYmlnIGZhbiBvZiBuYW1pbmcgdGhlc2Ugd2l0aCBhIGNvbW1hIGluIHRoZSBu
YW1lLiAgSXMgdGhlcmUgYSByZWFzb24NCnlvdSBhcmUgbm90IHVzaW5nIGRhc2ggb3IgdW5kZXJz
Y29yZT8NCg0KRG8geW91IGFudGljaXBhdGUgYSBjb252ZW50aW9uIG9mICA8cHJvZHVjZXI+IDxi
b2FyZC1vci1wcm9kdWN0LW5hbWU+IHR1cGxlcyBmb3INCnRoZSBmaWxlbmFtZT8NCiAtLSBUaW0N
Cg0KPiAgMSBmaWxlIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKykNCj4gIGNyZWF0ZSBtb2RlIDEw
MDY0NCB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9kZXZpY2VzL2JvYXJkcy9nb29nbGUsc3BoZXJp
b24NCj4gDQo+IGRpZmYgLS1naXQgYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9kZXZpY2VzL2Jv
YXJkcy9nb29nbGUsc3BoZXJpb24gYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9kZXZpY2VzL2Jv
YXJkcy9nb29nbGUsc3BoZXJpb24NCj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gaW5kZXggMDAw
MDAwMDAwMDAwLi5kYjlhMTdjY2NkMDMNCj4gLS0tIC9kZXYvbnVsbA0KPiArKysgYi90b29scy90
ZXN0aW5nL3NlbGZ0ZXN0cy9kZXZpY2VzL2JvYXJkcy9nb29nbGUsc3BoZXJpb24NCj4gQEAgLTAs
MCArMSwxMiBAQA0KPiArIyBFeGFtcGxlIHRlc3QgZGVmaW5pdGlvbiBmb3IgR29vZ2xlIFNwaGVy
aW9uIENocm9tZWJvb2sNCj4gKyMNCj4gKyMgRm9ybWF0Og0KPiArIyAgIHVzYnxwY2kgdGVzdF9u
YW1lIG51bWJlcl9vZl9tYXRjaGVzIGZpZWxkPXZhbHVlIFsgZmllbGQ9dmFsdWUgLi4uIF0NCj4g
KyMNCj4gKyMgVGhlIGF2YWlsYWJsZSBtYXRjaCBmaWVsZHMgdmFyeSBieSBidXMuIFRoZSBmaWVs
ZC12YWx1ZSBtYXRjaCBwYWlycyBmb3IgYQ0KPiArIyBkZXZpY2UgY2FuIGJlIHJldHJpZXZlZCBm
cm9tIHRoZSBkZXZpY2UncyBtb2RhbGlhcyBhdHRyaWJ1dGUgaW4gc3lzZnMuIEENCj4gKyMgc3Vi
c2V0IG9mIHRoZSBmaWVsZHMgbWF5IGJlIHVzZWQgdG8gbWFrZSB0aGUgbWF0Y2ggbW9yZSBnZW5l
cmljIHNvIGl0IGNhbiB3b3JrDQo+ICsjIHdpdGggdGhlIGRpZmZlcmVudCBoYXJkd2FyZSB2YXJp
YW50cyBvZiBhIGRldmljZSBvbiB0aGUgbWFjaGluZS4NCj4gK3VzYiBjYW1lcmEgMSBpYz0wZSBp
c2M9MDEgaXA9MDANCj4gK3VzYiBibHVldG9vdGggMSBpYz1lMCBpc2M9MDEgaXA9MDEgaW49MDAN
Cj4gK3BjaSB3aWZpIDEgdj0xNGMzIGQ9Nzk2MQ0KPiAtLQ0KPiAyLjQyLjENCg0K

