Return-Path: <linux-kselftest+bounces-7503-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF1689E495
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Apr 2024 22:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F6511C210EE
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Apr 2024 20:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43BB0158846;
	Tue,  9 Apr 2024 20:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZPEdseiB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1FC13E3E8;
	Tue,  9 Apr 2024 20:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712695239; cv=none; b=HTXDE0bs5t1kD4kCXQ4BaKp6dnaAVI6SU+XraI6efhE6MjYzt0n3lgdN/IR+MyLjxgxgsN0P6OEg3bNghiRbZG0svjT+MsKFZC2KbH//AO/JdXGoMFMdVe5N1xch3Cce+dsR+aiq8G7bZyEoSni9QUXnhgAVgwjYZzr6a2OC5Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712695239; c=relaxed/simple;
	bh=QjNSSY66Qn3fpHE7t3xN6VwDZVTkupieYJdnQIRVOa0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=cyLxjekUfPI/YtBSYrU9+UrtpXsLUdVAXXCkq4sU6MFDk5/iddoUcq5rtSsCjEo7yc4Qrn+4XwTQ1sJ07FAv2QdcqsOqKDOK4VwbkCoC/xwnHYFrMVz7dSuoZYPKCgxXYvVX9KiesRMbOANA2+tlyU07bIHwX6bXLV1oYQ8Ecxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZPEdseiB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7910C433C7;
	Tue,  9 Apr 2024 20:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712695238;
	bh=QjNSSY66Qn3fpHE7t3xN6VwDZVTkupieYJdnQIRVOa0=;
	h=From:Date:Subject:To:Cc:From;
	b=ZPEdseiB8PUHZk4Nrm2rxQ+hRppYNTRuvDsdcDG5tUC7S6hKsPhc83k03H8TkR5pN
	 IFu/X26ltYYGl5Sa5bu72Ll1VQP8yMkhR2y8ABDGaf8S2a6OREnC8xmEWn2ObJPWdm
	 aYPTcrluUOJqQm34E6UOZXhoLAEE36BmSN9dy8BPJ9QZcvgdRnEUsG24i4V2yFqpQc
	 CoDzO0fcC9yn7t73ma6YW7r42r4++/2dLpmEL0EYiT+BW8J0eAakONiIggkgfOMp5n
	 3MQuzh1IwyPKtPqmtFNrj8gqD21TfIoKzSdYSduYtWUnU6r+3/PmVr0s8upPOIkPjx
	 BXIYYRIl8Hhkw==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 09 Apr 2024 21:40:32 +0100
Subject: [PATCH] selftests/clone3: Correct log message for waitpid()
 failures
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240409-kselftest-clone3-waitpid-v1-1-2b31e4aaac16@kernel.org>
X-B4-Tracking: v=1; b=H4sIAL+nFWYC/x3MQQqEMAxA0atI1hPo2FbEqwyzkJpoUKo0ZUaQ3
 t3i8i3+v0ApCSkMzQWJfqKyx4r3q4GwjHEmlKkaWtM644zHVWnjTJoxbHski/9R8iETdn1wvbW
 BPTPU/EjEcj7rz7eUGx/DwbJqAAAA
To: Christian Brauner <brauner@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1103; i=broonie@kernel.org;
 h=from:subject:message-id; bh=QjNSSY66Qn3fpHE7t3xN6VwDZVTkupieYJdnQIRVOa0=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmFafEQiwprOZALX3sQJyJ5+qdeqYdrvpE8CNl/2Bv
 WAs+7SaJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZhWnxAAKCRAk1otyXVSH0IX8B/
 4sMqd+yPOS+o3NzuZH+mjJ39Mi0De7fhC35ion9Xcn+88nvB7Ac+RV+Dk/k6LLsBrUvA/AhV/lmMr1
 BfrQnmJzaRu+IbBpEYqtv7IEH231qrYhYZfKz32HGPQNApQymg2tZWHCcsF7bbvAlyM3onzp9NqWzi
 dznw5f2iJW61eLOId9Y8qhAH0jWZ8pCEengeaQHb15ySs0rf4CjtJBcUt5UytCjYtwvWtyCAw6htjG
 DTYJ57YhYrsd97kfN1hktdAMfUdjHEr/cOZ1FAUgZUc8ScHl9LFdv+uDFmPWOqIpt8q6SA+ZHg9BCj
 xLN4vHvYXYmOIEFVMdUEFFdwDTIUKU
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

When logging an error from calling waitpid() on the child we print a
misleading error message saying that the error we report was returned by
the chilld. Fix this to say the error is from waitpid().

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/clone3/clone3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/clone3/clone3.c b/tools/testing/selftests/clone3/clone3.c
index 3c9bf0cd82a8..eb108727c35c 100644
--- a/tools/testing/selftests/clone3/clone3.c
+++ b/tools/testing/selftests/clone3/clone3.c
@@ -95,7 +95,7 @@ static int call_clone3(uint64_t flags, size_t size, enum test_mode test_mode)
 			getpid(), pid);
 
 	if (waitpid(-1, &status, __WALL) < 0) {
-		ksft_print_msg("Child returned %s\n", strerror(errno));
+		ksft_print_msg("waitpid() returned %s\n", strerror(errno));
 		return -errno;
 	}
 	if (WEXITSTATUS(status))

---
base-commit: 8cb4a9a82b21623dbb4b3051dd30d98356cf95bc
change-id: 20240405-kselftest-clone3-waitpid-68c4833cf5ff

Best regards,
-- 
Mark Brown <broonie@kernel.org>


