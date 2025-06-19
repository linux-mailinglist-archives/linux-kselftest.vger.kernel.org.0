Return-Path: <linux-kselftest+bounces-35339-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03E1BADFCCB
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Jun 2025 07:18:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE7E7189D868
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Jun 2025 05:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A5E824167E;
	Thu, 19 Jun 2025 05:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q3mfhmfG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C2B23A564;
	Thu, 19 Jun 2025 05:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750310322; cv=none; b=sYvdW/2bYoLSBq62OWGNHCMs0FF3K2BZnK/Gyh+0gcDWmcHZkoA0SYU16L8UjjgmBzoKrW6mOSXzBH7ruNXkGAMsHVOQuWhCYl9GhdDD2LFFGs7MAkuQifFpdzwZSgOnEq8X60008EYEvDAfdkUeM1tcAJGt+0qov2YXjJXxFHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750310322; c=relaxed/simple;
	bh=/ASTVkIJ/zIGMOA+ht2vHucxDWTZ9iKbrXVkoSRNYqU=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=YbBsqB5LVhGNRF9JSUmWchk6P5ojpcsSTgPMakg3kH8MBN/elWC4L2XA85f0sMa+f4+EYKN2mkpqVT4S3jkBLbcr60y9+WiMeh2SoAvrKmO2J8kwdcnfRRHi8Ptf7KiSCy+81ZOYDx4xD6R0kD5JUGvlQGbPnOPQBM0JFKnjZB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q3mfhmfG; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-23694cec0feso3945225ad.2;
        Wed, 18 Jun 2025 22:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750310320; x=1750915120; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/ASTVkIJ/zIGMOA+ht2vHucxDWTZ9iKbrXVkoSRNYqU=;
        b=Q3mfhmfGtcHJNG8PYlfbn80QtE7Nyx1fKhkT9Fdzth/XXo2tGy5KEtjQsAhLbh90At
         9RX3KRh3TutljznjEbZLxtfskD1dVLI8qMZmJf4pm5PlbstEJiutGFrFleCUnvOaPhUb
         i50qipfvUNPTli8AUaNmJwulZdBDAx9zkmkU5p9LUU7Q8pXRxKtQULIu4IJguPGofy8a
         8fBJ72ZoxApkTd/jfKGqapyA6y+4UTsdbe0uZtI160R1/fr2cz3DZJLpGmXZxhgAKSDz
         1nhDbr/AbzU2+ENEmxdP4ZE37Mp6mLuZOy3eqXtTITQI9WxVPyMmEwYU06NCocRMGACq
         ywIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750310320; x=1750915120;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/ASTVkIJ/zIGMOA+ht2vHucxDWTZ9iKbrXVkoSRNYqU=;
        b=wc1NgfClQ2wGdNqZVZxixnOHh5bPAju14TeimMU59CThksLo2pQ/ZGiUg4Mg/n7QUX
         0rcIyFzZQh2+iR1v56lzs0mTGasi4kKBkw8IVFQ6ww08B0E6Z0bnGqPZZQUOQLC6LmCL
         NBQcHpyvyjB3g6AvVI1UlMgV4VLpDiddEO6uHKSCfSkpH/tPqX+DFJct+VC+ov8qQjeA
         fD0M3gj32RTvNxfuY3BKCbfmHFGt2Hl8N2exh8sMqjYXiF0SAMo7SeTJFLW9sC24nsEv
         yGt2MQ37szVgdhv6Hbq0Hx2YF0ziyt2U6zuKXnbOME4iSUUBRQ3ZvRKbCESZPPMDuH6V
         EZUg==
X-Forwarded-Encrypted: i=1; AJvYcCUw8bk2exhEDWUTJ0VZenYuWfMlKcN1MXiLEKa1SXayublEqPObzc/YmCZoOmGQvABEKSJ+a/701Gc=@vger.kernel.org, AJvYcCVaHBj0noBRPC/M4RHmV1+0J6IbG376FtQzXyMrJ3cUeqAvP/R6WPR9CA+wIkAB3o4GVEWJEuInn15Y5TG0hAg=@vger.kernel.org, AJvYcCW53POE1h296tI4l1dkKTEWXrBoUyuqwJ1A6Mra3z9XfHwSfcDkYHQUpEb60EfIbarpTYbXN8X5addkijPR@vger.kernel.org, AJvYcCWY1b1CB8ysrzVq0N6XQOqmrSRDghqt7ZO1vCixx3sX+63MADSC8bqYCXvi+G0A5yVmPJZO/XgDKQTAtjfG@vger.kernel.org, AJvYcCWoJC4jB6lRBC5+4KynCod9aqVbyN8NO1OVTgN1+a/pH/nU4xi5ZMmQQIOtuCRh6mmSim6ot9O4VlnI@vger.kernel.org, AJvYcCWvEL98zeFS/oKUdmqNriPkv4oisRO8Wx/he0BusbMCfXXbYcNhlRf6UcJ3k303B5K93saqqSKUIkepgs5dYNW7@vger.kernel.org, AJvYcCXeSvhWGA8RZp+73it3U5BJjJW1YpY7wjV5kLV4GPm0Y0IlG7pE1qSFIcBPpKyQICtWWoJv8hsqG2vn@vger.kernel.org, AJvYcCXhQ2Kw+/vQRArRKopXCSdE5E09yxZ5WJ/Hrq7IXpjBL+Y0vM9T1Kb/ZjmIHjlkqVz0XKuNnDsb@vger.kernel.org, AJvYcCXzBUjiatjDntdHoLQaGLEcLAwBvU4NGKoV1P+Z6rParO+zOpWxdTm2uCImL3FPuZCtiHuV/mHrvbw9aYs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIGsyaxEhZHU4+YNUuSB4g/vKoYbKrn1C8wzvP5KLAtUIby1BA
	Qu1jDcfTvtc9QGpna6piPvnu+ji/p25dWbcz4IdIjVp0oGRJLZNq5k8t
X-Gm-Gg: ASbGncuCyUdKZmqGkgiSRXoxt32Oaf+ZAF314CWHiTlxBb4WtVvHrRiyttOGUPK+Cio
	n2IWZceqRYKKuOVkqQMxSZgAOeQzcJ5kv7lCsSiZ6qN7nLS9F7fr41WgonJu48sQzqzLsJUxAKf
	gDAGlV3K6LNmEyB0joNh3hocnNMlBDzHu5Pug4qNZ80r+OUm9CrWe85mG9Q00N8bdO9Yyq7IlCe
	z31cfhrgk4Ew9no/N22iNLOn3mQg8C791SdCE2gZqmgAgg19xhVd7BmkER5fauAFbd3pGn0eZVW
	q8tD8FCzyJtqqVffavx2SE8gmQywG6RjeqyyOWw7gBRcydv5vhEPlxVNqYVlXU/89ebJFIjIQ2b
	wC/enn0d586a3dRUqsaTytSdwTi2IfIieinR66XTv
X-Google-Smtp-Source: AGHT+IEvcoWS+/mpCBS9HRGMoVVCn5GZ2BtlFZ10WJnLh4P0CWaOXTjNBc1tb/94RF8WfyU78YJazg==
X-Received: by 2002:a17:903:4b4c:b0:235:6e1:3edf with SMTP id d9443c01a7336-2366b122194mr301022585ad.34.1750310319710;
        Wed, 18 Jun 2025 22:18:39 -0700 (PDT)
Received: from localhost (p5332007-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.34.120.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365deca344sm110992075ad.203.2025.06.18.22.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 22:18:39 -0700 (PDT)
Date: Thu, 19 Jun 2025 14:18:17 +0900 (JST)
Message-Id: <20250619.141817.2042938522863410452.fujita.tomonori@gmail.com>
To: tamird@gmail.com
Cc: masahiroy@kernel.org, nathan@kernel.org, ojeda@kernel.org,
 alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
 bjorn3_gh@protonmail.com, a.hindborg@kernel.org, aliceryhl@google.com,
 tmgross@umich.edu, dakr@kernel.org, gregkh@linuxfoundation.org,
 rafael@kernel.org, brendan.higgins@linux.dev, davidgow@google.com,
 rmoar@google.com, bhelgaas@google.com, mcgrof@kernel.org,
 russ.weight@linux.dev, robh@kernel.org, saravanak@google.com,
 abdiel.janulgue@gmail.com, daniel.almeida@collabora.com,
 robin.murphy@arm.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, fujita.tomonori@gmail.com, nicolas.schier@linux.dev,
 frederic@kernel.org, lyude@redhat.com, tglx@linutronix.de,
 anna-maria@linutronix.de, lossin@kernel.org, kwilczynski@kernel.org,
 jstultz@google.com, sboyd@kernel.org, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, leitao@debian.org, viresh.kumar@linaro.org,
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kunit-dev@googlegroups.com, linux-pci@vger.kernel.org,
 linux-block@vger.kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, netdev@vger.kernel.org,
 linux-mm@kvack.org, linux-pm@vger.kernel.org, nouveau@lists.freedesktop.org
Subject: Re: [PATCH v12 5/6] rust: enable `clippy::cast_lossless` lint
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <20250615-ptr-as-ptr-v12-5-f43b024581e8@gmail.com>
References: <20250615-ptr-as-ptr-v12-0-f43b024581e8@gmail.com>
	<20250615-ptr-as-ptr-v12-5-f43b024581e8@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-7
Content-Transfer-Encoding: base64

T24gU3VuLCAxNSBKdW4gMjAyNSAxNjo1NTowOSAtMDQwMA0KVGFtaXIgRHViZXJzdGVpbiA8dGFt
aXJkQGdtYWlsLmNvbT4gd3JvdGU6DQoNCj4gQmVmb3JlIFJ1c3QgMS4yOS4wLCBDbGlwcHkgaW50
cm9kdWNlZCB0aGUgYGNhc3RfbG9zc2xlc3NgIGxpbnQgWzFdOg0KPiANCj4+IFJ1c3SicyBgYXNg
IGtleXdvcmQgd2lsbCBwZXJmb3JtIG1hbnkga2luZHMgb2YgY29udmVyc2lvbnMsIGluY2x1ZGlu
Zw0KPj4gc2lsZW50bHkgbG9zc3kgY29udmVyc2lvbnMuIENvbnZlcnNpb24gZnVuY3Rpb25zIHN1
Y2ggYXMgYGkzMjo6ZnJvbWANCj4+IHdpbGwgb25seSBwZXJmb3JtIGxvc3NsZXNzIGNvbnZlcnNp
b25zLiBVc2luZyB0aGUgY29udmVyc2lvbiBmdW5jdGlvbnMNCj4+IHByZXZlbnRzIGNvbnZlcnNp
b25zIGZyb20gYmVjb21pbmcgc2lsZW50bHkgbG9zc3kgaWYgdGhlIGlucHV0IHR5cGVzDQo+PiBl
dmVyIGNoYW5nZSwgYW5kIG1ha2VzIGl0IGNsZWFyIGZvciBwZW9wbGUgcmVhZGluZyB0aGUgY29k
ZSB0aGF0IHRoZQ0KPj4gY29udmVyc2lvbiBpcyBsb3NzbGVzcy4NCj4gDQo+IFdoaWxlIHRoaXMg
ZG9lc24ndCBlbGltaW5hdGUgdW5jaGVja2VkIGBhc2AgY29udmVyc2lvbnMsIGl0IG1ha2VzIHN1
Y2gNCj4gY29udmVyc2lvbnMgZWFzaWVyIHRvIHNjcnV0aW5pemUuICBJdCBhbHNvIGhhcyB0aGUg
c2xpZ2h0IGJlbmVmaXQgb2YNCj4gcmVtb3ZpbmcgYSBkZWdyZWUgb2YgZnJlZWRvbSBvbiB3aGlj
aCB0byBiaWtlc2hlZC4gVGh1cyBhcHBseSB0aGUNCj4gY2hhbmdlcyBhbmQgZW5hYmxlIHRoZSBs
aW50IC0tIG5vIGZ1bmN0aW9uYWwgY2hhbmdlIGludGVuZGVkLg0KPiANCj4gTGluazogaHR0cHM6
Ly9ydXN0LWxhbmcuZ2l0aHViLmlvL3J1c3QtY2xpcHB5L21hc3Rlci9pbmRleC5odG1sI2Nhc3Rf
bG9zc2xlc3MgWzFdDQo+IFN1Z2dlc3RlZC1ieTogQmVubm8gTG9zc2luIDxiZW5uby5sb3NzaW5A
cHJvdG9uLm1lPg0KPiBMaW5rOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvRDhPUlRYU1VU
S0dMLjFLT0pBR0JNOEY4VE5AcHJvdG9uLm1lLw0KPiBSZXZpZXdlZC1ieTogQmVubm8gTG9zc2lu
IDxiZW5uby5sb3NzaW5AcHJvdG9uLm1lPg0KPiBSZXZpZXdlZC1ieTogQm9xdW4gRmVuZyA8Ym9x
dW4uZmVuZ0BnbWFpbC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IFRhbWlyIER1YmVyc3RlaW4gPHRh
bWlyZEBnbWFpbC5jb20+DQo+IC0tLQ0KPiAgTWFrZWZpbGUgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHwgMSArDQo+ICBkcml2ZXJzL2dwdS9kcm0vZHJtX3BhbmljX3FyLnJzICAgICAgfCA0
ICsrLS0NCj4gIGRyaXZlcnMvZ3B1L25vdmEtY29yZS9yZWdzLnJzICAgICAgICB8IDIgKy0NCj4g
IGRyaXZlcnMvZ3B1L25vdmEtY29yZS9yZWdzL21hY3Jvcy5ycyB8IDIgKy0NCj4gIHJ1c3QvYmlu
ZGluZ3MvbGliLnJzICAgICAgICAgICAgICAgICB8IDEgKw0KPiAgcnVzdC9rZXJuZWwvbmV0L3Bo
eS5ycyAgICAgICAgICAgICAgIHwgNCArKy0tDQo+ICBydXN0L3VhcGkvbGliLnJzICAgICAgICAg
ICAgICAgICAgICAgfCAxICsNCj4gIDcgZmlsZXMgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCA2
IGRlbGV0aW9ucygtKQ0KDQpGb3IgUEhZIHBhcnQ6DQoNCkFja2VkLWJ5OiBGVUpJVEEgVG9tb25v
cmkgPGZ1aml0YS50b21vbm9yaUBnbWFpbC5jb20+DQo=

