Return-Path: <linux-kselftest+bounces-13076-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3973924743
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jul 2024 20:26:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C58D2823BD
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jul 2024 18:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3AFC1C8FBE;
	Tue,  2 Jul 2024 18:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tW8/trxG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2054.outbound.protection.outlook.com [40.107.95.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F7F1DFE3;
	Tue,  2 Jul 2024 18:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719944759; cv=fail; b=dws7VzTv7e2X2OxAxtKELmdentg82Ss2+srf/oEmQC6PDrSG1yirKcIxEq2eEDmXbepI2Z8WYLz1vw0Y0PwR43RtXbe152aVKibpTjWVfTvoFfXQXt+D86PYRD5OhNsr41Dmjb3EvdKUFublvP/MbxML5sxFVUwdiHpHkHSKhTs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719944759; c=relaxed/simple;
	bh=ApZFb/OadEyomSSMoB91bbN9BVbgTC4xNr2CmsuPFXY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Xx2Tsp0H5x404AvYkIpwFHCUpQJBm7BiJcPUhvZJiOf/KyhaNIN0bHgGJng/nWVgWKbS5/u7bui63Xvr5Ge9/TkjY5fBcjrIUty3begyvh+URnGKpvmgp3WnRTKhhXA4TJ+DTZV6UEa/vEu2JjKIns46aP7w2Wn4VUh8O32q1vo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tW8/trxG; arc=fail smtp.client-ip=40.107.95.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B6JwZ5Pcz3qIu+PJj8NVBga6hVgVFZEOpky1zZEl9IFMlv0NnTp7UyHjZzkdhjpiGFZ0KOCH4Y3QPjhoYvwvjtpRW26lEsKZtwamb554EiX8XDECI+Ny2ubBM+qow6iezWWv0+WVQgOYn4zwMoWszBkITWlmrIuY7G5XnVT5+poVeFFMxz1TZbNnfyZraWzzwri060ecoJTXXVjegcvg4vfWnDxFTe7glF8MDfjqDOHOJ7uB+7SVMekBpKp8M0ZZ1SuG/dbDvExFKJhce0WeT5+JlVpOGsfcxp3e4YeCuYhoe5Y6tL0o0GWJ+dK2UtqzgH1+IaUQ3fW+yk4kVeWh/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YfKptGNR77B1746Nk6AAHZs7Pd6vyTZZyy89KZcNPhs=;
 b=EUDl8c4a/PVryDART8a67r4xWwJnDLhCRVVP9MNBTQ+sDEL1Odfv5fu/QFkLzGsCu+1p5ILo72kFdq3ZcLQ9isfV4mY+VmBaZVM9R3/t3UE9swtCAZJueGpcr69YUUBEQKjYcfeg5i84T2lOn7mpSjIa9gac0Rs3YLy24LSvLMEbmFWAh5kmVfE3hkKGYKfljCkt+aKAZG0NavdNxAZ4R+zGpy/q/wcyaSEpZZIEzN5qiAjdqdBkGruqiplWFayO9RdiObJwTluDxpJa0a/YGhDJ+cXbAE+hYgCYcGilqxkWJdM9hrsNzSnNy6CwcwTemIjngKlaWyhH+E7EOsyQtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YfKptGNR77B1746Nk6AAHZs7Pd6vyTZZyy89KZcNPhs=;
 b=tW8/trxGWBM2sTdeUwRt93YQquTZjBBQOzNljyUSPROWYJ/CymhAklaiFhg4vYCKZkQpfHHJWo6oigOr4QwKXdz8QWLm0YBnYxW8yzOyfXulUtFkNmD0AFPvS05klsaKDxLDJZ43MB2OXkSeEZYUknEOCTYOWeP6oKKZwCtMuQOT0xonjSFOevj5VFRjenwyvbjHXe/GB6st2thfmhIBYbiJ4KQpP2lBa16GvpaztGJAvqDMnqKRQe7ik0OL6sSa3Hjvmpzd0NKg51T841yDMBarMQbUacipfxJDlEzuFrQiQauBN0IGC5X7qLtgDYyo/uLzKhPHr4PRIzScul98bA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4140.namprd12.prod.outlook.com (2603:10b6:5:221::13)
 by CY8PR12MB7415.namprd12.prod.outlook.com (2603:10b6:930:5d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Tue, 2 Jul
 2024 18:25:49 +0000
Received: from DM6PR12MB4140.namprd12.prod.outlook.com
 ([fe80::657e:28eb:3569:4f91]) by DM6PR12MB4140.namprd12.prod.outlook.com
 ([fe80::657e:28eb:3569:4f91%7]) with mapi id 15.20.7719.029; Tue, 2 Jul 2024
 18:25:49 +0000
Message-ID: <b4720a40-6e74-4b1d-93ca-a3444e400a1a@nvidia.com>
Date: Tue, 2 Jul 2024 11:25:01 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] selftests/vDSO: fix clang build errors and
 warnings
To: Edward Liaw <edliaw@google.com>
Cc: Shuah Khan <shuah@kernel.org>, "Jason A . Donenfeld" <Jason@zx2c4.com>,
 Andy Lutomirski <luto@kernel.org>, Mark Brown <broonie@kernel.org>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>,
 Colin Ian King <colin.i.king@gmail.com>,
 Valentin Obst <kernel@valentinobst.de>, linux-kselftest@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev,
 Carlos Llamas <cmllamas@google.com>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>
References: <20240614233105.265009-1-jhubbard@nvidia.com>
 <20240614233105.265009-2-jhubbard@nvidia.com>
 <CAG4es9WQOOga8Oh9BOjr_JXy5gcUzVN0iTtfjN_HVdRj7_G7iQ@mail.gmail.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <CAG4es9WQOOga8Oh9BOjr_JXy5gcUzVN0iTtfjN_HVdRj7_G7iQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR04CA0017.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::27) To DM6PR12MB4140.namprd12.prod.outlook.com
 (2603:10b6:5:221::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4140:EE_|CY8PR12MB7415:EE_
X-MS-Office365-Filtering-Correlation-Id: dda7ad56-4b5e-4fc7-8eae-08dc9ac465a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TkxEYnk0WHB3M2llSmZpT0Z5S3JDcjYvcmxpVjhkNkRRUFRhdk9GVC9lMVV2?=
 =?utf-8?B?cC9ycWlqUEkvZHFvczgrTlB0SWt0ampGOFFGUncxOW1TUHZta2c0Ylhmd01u?=
 =?utf-8?B?OERMdjZqTWpDbm4yVUFKVEdEZzJHRlFVTmpXTFZGUnIvSUJXSDFDSExIQjFa?=
 =?utf-8?B?UjFpWXBzNzJkcVRDTzVDbEVVTldHYVhNMjF1TVhaejdWUStuNGZtN3R5VENM?=
 =?utf-8?B?TWNXQzFxVHRLSnl6ejd2QVJCYTFIbW9qRzlMUm9FbVUzUFBDWnVjckg2L0FL?=
 =?utf-8?B?VWdYQkRRNHlueGNidkpBUmhMMW9YR2Q4RFdOd1BUTlJvRjhHVU1nU2N2M0cr?=
 =?utf-8?B?VktFTHBHWEMyVHJTaUFDbmNoTzNURWdkZ2kwL1UrRGFEaThnOE9uaG1KYS9J?=
 =?utf-8?B?RTVJVElKakplTkJLajZmMnhsZDBPUHA5enRqYlpYbjBYcVpxZjhsYjVhN2Yw?=
 =?utf-8?B?WjBqVDdKalNJQzU1Qk4vK243cWM1cXlKVDl2U2k3dFZGemg3Z2RUYytLSkdx?=
 =?utf-8?B?bVN4YkNFNG0vRzBUWkxibEc4WG92K0FhKzRBWTJNTEFJaHFRTFVKaUZpbmIr?=
 =?utf-8?B?VmI5N0FZa0ZwRDNEMENqUTJaQnRXUG9vdG1EejJHZlJqVlBlWmxXeGhENHh5?=
 =?utf-8?B?ZVV5aFFvNWxFa0p3d1RSWHJncG9zRGJKbnF2R01USFRBR0Nram8vZVBLdjRO?=
 =?utf-8?B?RkhKQy83VVc0dVZyRUx2bHJwdHZERHhIYWJ4OGp0UXJIWC9HZXNtV3VLS0lB?=
 =?utf-8?B?dzdnTE84c3VPZmRMRDlqYld3TnlpT3diNTliQUxrUFVub04xaTQxYzBUeGY2?=
 =?utf-8?B?K25qR0xjWHpFaTNxWktJeXVLMHJHM1JURUFvV2VxWGlPRmRDNWJZcUF2Tk9m?=
 =?utf-8?B?QWRRMU9Yb0pqck5tRDlQNnZ4VTg3bDh5RWp5anlNZUZGN0Q0a1NhZzdUdjhW?=
 =?utf-8?B?VEYxY3c3eVplQml5dGp5V1RsNWpmaWluK2hFajJxUWhrbUtHL05QM2hxSmR5?=
 =?utf-8?B?MTkwelp4Tk1JcnhZZ2FSRlJuRjhMQy9LQlFEMGdyenNNbFhSSXJXTDR1MDAz?=
 =?utf-8?B?cU1vZ0lrWjcrUzBYa2U3TkxZNGR0S2hhTzJOVW1NakNuM2xpRlJzeFBSRjFx?=
 =?utf-8?B?NmRoZkR4Qm1qT1dvRVlKS3BOd1U1UDMrVmZZdWtyYjUvTjlJTEJaNmgwSGFZ?=
 =?utf-8?B?Y2ZPN1NMSmk2UThoMUJ0bTFKMDBKbVRDM3hiZjRTeUdCejI4LzZCeEVBejU1?=
 =?utf-8?B?dnlSVG9YU3BWMElPcXhkcEpsVm96WVEwOHB0Qks1bkd0TTRkYUZ6TDdUYzFT?=
 =?utf-8?B?ZkJaSW84SWw0TUFmMzAyZzRPbUNBeHRMYVR1QlA3eWFCTXdTalZwV1lIM3N3?=
 =?utf-8?B?cGpWbUFzcVFNQnJZYUpIdFc0VWloVlliN3J3VnJlamJmM2JBMjVxa1hadCtl?=
 =?utf-8?B?a2hyaFlCUFl4U0w5RUdlb29tZHd3S2lGMUZxRDZzcENhWWVhcnVXd2FSWThW?=
 =?utf-8?B?Vm1WSlRHOE5FaWNUd2RZWU5oWHZ2Y3EyclZ0TVVBd1JqUTNOdGQ0T2w2dVVX?=
 =?utf-8?B?aWgvS3NQM1IxYWp1T25vSlZxeSs5Smw1OXMxSFlBcHZ1Z0p3Q0hCZ3Fja09x?=
 =?utf-8?B?TDNTYW5rYU5tZHZYK090R0xkYXhKZW94YWN4cUlTbXdrQWE5cE1YZXRRalFG?=
 =?utf-8?B?RDF1UEVkOUtjOVJHeWFhZllPMXRoSkt1WnZkTC9yYVpoa2Y3R0l3NlFyM0Vy?=
 =?utf-8?B?aHR3VGhZaGNIZ3kyVjhYcjJ6eVpaQ3VIZ3RaVnBoTzk1bVVKUHNHdGtOZkUr?=
 =?utf-8?B?UDZycGVQRnFkbWhPbVdHUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4140.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bEhiWXJVUDFrWnhaVnQ5alluL1RxQ2hsN2RJSWRvQWZpcmFJbk9wN0psN1Ba?=
 =?utf-8?B?aXhmVmQwS0NoaHcvZ1JyN1hkWUpaVW9XL1hkRkNFdWlsU25kakV2WjVCdzdR?=
 =?utf-8?B?NGcxdlphZG5qSno3K1UzZGxFVUR3Q0tJUTZCakQ3OWRuQTh6dHJpVUU3UDVw?=
 =?utf-8?B?dC9qRVlqMzhRWVdud01rUVhmZzh2NU1WaHQxK3BXT1RuckUrN3o5OG5yOGx0?=
 =?utf-8?B?bGZJQzhkWEZ4WGZKTDBZMktya3NWYTE4eFVJcmsyMjk0U1VKVWQxK3c5S0xy?=
 =?utf-8?B?YVE2YU9Hc3NiV29RN0xhbmowaTRtdFRHaDgzY2lzQnkzNEpUZ2ZuWFVHbUZw?=
 =?utf-8?B?ZnhmYTlXY3l1VjRUOWMvZVRwRGFDK0taSSt0R1ZZSWZ4aGh3ejhCRXRSbWdH?=
 =?utf-8?B?Vm5RQktubUxKQWVRdGVzMnQxRTYvRFJmb1BvYVd3c0RtaWNRTnlCemRCait0?=
 =?utf-8?B?eGRRL3lpNlZYOXFJaVI5cWIrOEtNUjF1S2lOL2NFNmJ1aEwzd2dYVFcrSU9m?=
 =?utf-8?B?VXpTTHRHNnZuUFgrZ3ZnZlduZUM2bHYrTlI2c0pIaVdSVjh2eEZRclVpTytT?=
 =?utf-8?B?S01YdVgrMzA1TTFqZWtmY1gzN2F3MzV2bysxSTBjYTNBbFRLY283VUo3VENO?=
 =?utf-8?B?S3FvRXo4clJjNVRxMCtubHUwNnZuK0lXa0hoRWthaC9oYnZldnlmVHM4Rm8r?=
 =?utf-8?B?c1FrVThoelRUNVI3Y3d3L05OM01mWHozMW9ROGRpbFI0WkN2YW5zZVZ6b210?=
 =?utf-8?B?ek91cEkwcHZDUEpZZUtEQktQRFlDYjhaVUt5SHA3RzRYd1VoL3ZkQjgyRUlJ?=
 =?utf-8?B?a3FYUnRWTGgvM2Z1NloxL3JYMzdubVBjelVEM1FkNE4rYnRBS3YyTTYyQ0FE?=
 =?utf-8?B?Y3ByOVRYNzV5ay91SGhPNnhjV2tKNzVTNTQ1ZS9ZdHZnUVpUSFBKU3lDTXlC?=
 =?utf-8?B?VTZNQ2FiakpDWlh2TnZ4Z3hrSTdTREZZcW9YOUNOek9ldEZJVTluOUxwWVpI?=
 =?utf-8?B?aElwMEx5ZjZZWFNuSzJaM2NXUWJDWDZ4QnlYZkc3K2xrUmpweGM3b1pYd2wz?=
 =?utf-8?B?QkxscUFBa3IrMXZHelkzdHhQM043UE9BVkZYUk80dWpzdmRrK08zQ29nODZu?=
 =?utf-8?B?M1YwNDdOWXJ4ZGZCMnd0SlR2c3MxbHVXNjdCYitpMnFYSWFVOFljSlpPTzc0?=
 =?utf-8?B?TEEwNzFWVy9ZMmNMNGlzeElRWnBvZk85T0F5TEVXQWhob1Y2aUtFejR6RUQx?=
 =?utf-8?B?V3AyVXdxa2RwOFpDcnVSQ2pOcjVOeXMxczN6YVYxS3hIMjFMK3ovcnFyV3NK?=
 =?utf-8?B?aENxeXpnUnR0WlgvUUtLdngvWEZ5R3RjSzF2UXpYZnY3Mys5ODJvcHEzMGxV?=
 =?utf-8?B?TzBwanYyL1NsUytoR1RaRmNlY0NFUUpES0RRalc0bkk2M3hrUnJjdWl5YkpT?=
 =?utf-8?B?SDYvNm5ka0plSW9lbFVuM2NwVVpySzVqRjEzV21nSlpSdmNocTFjUVdoa0tq?=
 =?utf-8?B?QzVHbVFIdnJkNDhod25TQVRKRC8rc3V4Mk90bTZaQ013QVo2YXI0OUcxWkd0?=
 =?utf-8?B?NHh0bUMvWkNzRy9uS01GTzlacHZaeXBWWFk0b29UY0R2R3Rvc0tpdWR1R1gz?=
 =?utf-8?B?R0d5Wkk2Ty9TcDhZbGJDQVlndzZ3ZWJlYzBkdWZmVUdyYzkvallodkFuZ2Zh?=
 =?utf-8?B?TExJNHNqSHU3dzdJaGlZeXdrZ3FUWFFzT0VjRWxtZ2l0ejl5Y3U4M2l3d0xN?=
 =?utf-8?B?QnVmTk1lYzJ1MStxS09Xa1JSa3UxNjJVRm00WDN5ZS90OUNFUm5nY3MwNS9m?=
 =?utf-8?B?SHhrNmoxaHBOc0s3NFo2QXVBRC9ZK0l5NnkvZlI1ZmtxQnB6czdZd3JlMjh1?=
 =?utf-8?B?Rk9sRm1OdjBhQ1paSllrVWFWYzh2YzJaUklvQVJqSnhsVGFyMWZIOGU4NlVR?=
 =?utf-8?B?VW1FUWNWazhVL3owSjlRbXVhNENVdXlDU3dnS3I2bnhmRFVjRGMwTUlNVmMw?=
 =?utf-8?B?YncrQkhURjBDcXNJR3ZoS0xvSFd1bjF3emZtK1phRE1tSGRCNndvenlzWWFv?=
 =?utf-8?B?VW40TFhKVTE3SmljKzlrdnl5U3FiK1JxbW1xeTAyWGZ3Skh1ak1PWUc1c2k2?=
 =?utf-8?B?Yk8rUG5UeWdFMW1ROWNWdWttakZDZWovdmxXRHZRK1pxZzA2T0VkMTU5YW1s?=
 =?utf-8?B?Nnc9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dda7ad56-4b5e-4fc7-8eae-08dc9ac465a5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4140.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2024 18:25:49.0507
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v9rS8ARUToiF7Ldlv3vu0jCmuFYBIchgkyrvzgOa2k2J1IDHc1EDU5DdY4yrKqdcVcOi6hi+27urV976RQGH9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7415

On 7/2/24 11:12 AM, Edward Liaw wrote:
> On Fri, Jun 14, 2024 at 4:31 PM John Hubbard <jhubbard@nvidia.com> wrote:
...
> Hi John,
> Could you try re-submitting this series with the RESEND prefix?
> 
> Thanks,
> Edward

Sure. Is that the key, for kselftests? Because I've got 5+ small
patchsets that are languishing there, and I'm at a loss for how to even
get a response, much less get something merged.


thanks,
-- 
John Hubbard
NVIDIA


